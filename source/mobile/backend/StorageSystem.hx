package mobile.backend;

import sys.FileSystem;
import sys.io.File;
import openfl.utils.Assets;

class StorageSystem {

    public static var saveDir:String = getSaveDir();

    // Retorna a pasta de salvamento para Android
    public static function getSaveDir():String {
        // Usando o path do app interno em Android
        #if android
        var dir = sys.FileSystem.getUserDirectory() + "/.nightmarevision/";
        #else
        var dir = sys.FileSystem.getUserDirectory() + "/NightmareVision/";
        #end

        if (!FileSystem.exists(dir)) {
            FileSystem.createDirectory(dir);
        }
        return dir;
    }

    // Salva um arquivo de texto
    public static function saveText(fileName:String, content:String):Void {
        var path = saveDir + fileName;
        try {
            File.saveContent(path, content);
        } catch (e:Dynamic) {
            trace('Error saving file: $path -> $e');
        }
    }

    // Lê um arquivo de texto
    public static function loadText(fileName:String):String {
        var path = saveDir + fileName;
        try {
            if (FileSystem.exists(path)) {
                return File.getContent(path);
            } else {
                return "";
            }
        } catch (e:Dynamic) {
            trace('Error loading file: $path -> $e');
            return "";
        }
    }

    // Verifica se o arquivo existe
    public static function exists(fileName:String):Bool {
        return FileSystem.exists(saveDir + fileName);
    }

    // Deleta um arquivo
    public static function delete(fileName:String):Bool {
        var path = saveDir + fileName;
        try {
            if (FileSystem.exists(path)) {
                FileSystem.deleteFile(path);
                return true;
            }
        } catch (e:Dynamic) {
            trace('Error deleting file: $path -> $e');
        }
        return false;
    }

    // Lista arquivos na pasta de salvamento
    public static function listFiles():Array<String> {
        try {
            return FileSystem.readDirectory(saveDir);
        } catch (e:Dynamic) {
            trace('Error listing files in $saveDir -> $e');
            return [];
        }
    }

}
