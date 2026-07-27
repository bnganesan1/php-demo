<?php
echo "<h1>Hello OpenShift!</h1>";

echo phpinfo();

$appname = getenv('TEMP_PATH');

echo $appname;

?>
