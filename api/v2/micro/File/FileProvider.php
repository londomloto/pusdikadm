<?php
namespace Micro\File;

class FileProvider {

    public function isImage($file) {
        $info = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($info, $file);

        finfo_close($info);

        $type = array('image/jpeg', 'image/png', 'image/gif');

        if (in_array($mime, $type)) {
            return TRUE;
        }
        
        return FALSE;
    }

    public function formatSize($bytes, $precision = 2) {
        $units = array('B', 'KB', 'MB', 'GB', 'TB');
        $bytes = max($bytes, 0);
        $power = floor(($bytes ? log($bytes) : 0) / log(1024));
        $power = min($power, count($units) - 1);

        $bytes /= (1 << (10 * $power)); 

        return round($bytes, $precision) . ' ' . $units[$power];
    }

    public function exists($path) {
        return file_exists($path) && ! is_dir($path);
    }

    public function download($file, $name = NULL) {
        $info = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($info, $file);

        finfo_close($info);
        
        if (is_null($name)) {
            $info = pathinfo($file);
            $name = '';

            if (isset($info['filename'])) {
                $name .= $info['filename'];
            }

            if (isset($info['extension'])) {
                $name .= '.'.$info['extension'];
            }
        }

        // header('Set-Cookie: downloadtoken=finish; path=/');
        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Cache-Control: public");
        header("Content-Description: File Transfer");
        header("Content-type: ".$mime);
        header("Content-Disposition: attachment; filename=\"".$name."\"");
        header("Content-Transfer-Encoding: binary");
        header("Content-Length: ".filesize($file));
        header("X-Download-Status: finish");

        ob_start();

        if ($stream = fopen($file, 'r')) {
            while ( ! feof($stream)) {
                echo fread($stream, 1024);
                ob_flush();
                flush();
            }
            fclose($stream);
        }

        ob_end_clean();

        exit();
    }

}