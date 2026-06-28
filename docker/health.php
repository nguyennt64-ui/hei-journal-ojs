<?php
header('Content-Type: application/json');

$root = __DIR__;
$checks = [
    'cache_manager_file' => is_file($root . '/lib/pkp/classes/cache/CacheManager.php'),
    'files_dir_writable' => is_dir('/var/www/files') && is_writable('/var/www/files'),
    'cache_dir_writable' => is_dir($root . '/cache') && is_writable($root . '/cache'),
    'public_journals_dir' => is_dir($root . '/public/journals'),
    'public_site_dir' => is_dir($root . '/public/site'),
];

require_once $root . '/lib/pkp/lib/vendor/autoload.php';
$checks['cache_manager_class'] = class_exists('PKP\\cache\\CacheManager');

$configPath = $root . '/config.inc.php';
$checks['config_exists'] = is_file($configPath);

if ($checks['config_exists']) {
    try {
        $mysqli = @new mysqli(getenv('DB_HOST') ?: '127.0.0.1', getenv('DB_USER') ?: 'ojs', getenv('DB_PASSWORD') ?: 'ojs', getenv('DB_NAME') ?: 'ojs_local');
        $checks['db_connect'] = $mysqli->connect_errno === 0;
        if ($checks['db_connect']) {
            $result = $mysqli->query('SELECT COUNT(*) AS c FROM journals');
            $row = $result ? $result->fetch_assoc() : null;
            $checks['journal_rows'] = (int) ($row['c'] ?? 0);
            $mysqli->close();
        }
    } catch (Throwable $e) {
        $checks['db_connect'] = false;
        $checks['db_error'] = $e->getMessage();
    }
}

$ok = $checks['cache_manager_file']
    && $checks['cache_manager_class']
    && $checks['files_dir_writable']
    && $checks['cache_dir_writable']
    && ($checks['config_exists'] ? ($checks['db_connect'] ?? false) : false);

// #region agent log
error_log(json_encode([
    'sessionId' => 'd19d71',
    'hypothesisId' => 'H10',
    'location' => 'health.php',
    'message' => 'render_health_check',
    'data' => $checks,
    'timestamp' => (int) (microtime(true) * 1000),
]));
// #endregion

http_response_code($ok ? 200 : 503);
echo json_encode(['ok' => $ok, 'checks' => $checks], JSON_PRETTY_PRINT);
