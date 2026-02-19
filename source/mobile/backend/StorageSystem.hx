package mobile.backend;

import sys.FileSystem;
import sys.io.File;

#if android
import lime.system.System;
import lime.utils.Bytes;
#end

class StorageSystem
{
    /** Caminho base de armazenamento **/
    public static var basePath:String = initBasePath();

    /**
     * Inicializa o diretório seguro
     */
    static function initBasePath():String
    {
        #if android
        var path = System.applicationStorageDirectory;

        if (!FileSystem.exists(path))
            FileSystem.createDirectory(path);

        return path;
        #else
        var path = "mobileData/";

        if (!FileSystem.exists(path))
            FileSystem.createDirectory(path);

        return path;
        #end
    }

    /**
     * Retorna caminho completo de um arquivo
     */
    public static function getPath(file:String):String
    {
        return basePath + "/" + file;
    }

    /**
     * Salvar texto
     */
    public static function save(file:String, content:String):Void
    {
        var path = getPath(file);

        try
        {
            File.saveContent(path, content);
        }
        catch (e:Dynamic)
        {
            trace("StorageSystem SAVE ERROR: " + e);
        }
    }

    /**
     * Carregar texto
     */
    public static function load(file:String):String
    {
        var path = getPath(file);

        try
        {
            if (FileSystem.exists(path))
                return File.getContent(path);
        }
        catch (e:Dynamic)
        {
            trace("StorageSystem LOAD ERROR: " + e);
        }

        return "";
    }

    /**
     * Salvar bytes (útil pra saves binários)
     */
    public static function saveBytes(file:String, bytes:Bytes):Void
    {
        var path = getPath(file);

        try
        {
            File.saveBytes(path, bytes);
        }
        catch (e:Dynamic)
        {
            trace("StorageSystem SAVE BYTES ERROR: " + e);
        }
    }

    /**
     * Carregar bytes
     */
    public static function loadBytes(file:String):Bytes
    {
        var path = getPath(file);

        try
        {
            if (FileSystem.exists(path))
                return File.getBytes(path);
        }
        catch (e:Dynamic)
        {
            trace("StorageSystem LOAD BYTES ERROR: " + e);
        }

        return null;
    }

    /**
     * Verifica se arquivo existe
     */
    public static function exists(file:String):Bool
    {
        return FileSystem.exists(getPath(file));
    }

    /**
     * Deleta arquivo
     */
    public static function delete(file:String):Void
    {
        var path = getPath(file);

        try
        {
            if (FileSystem.exists(path))
                FileSystem.deleteFile(path);
        }
        catch (e:Dynamic)
        {
            trace("StorageSystem DELETE ERROR: " + e);
        }
    }

    /**
     * Lista arquivos da pasta
     */
    public static function list():Array<String>
    {
        try
        {
            return FileSystem.readDirectory(basePath);
        }
        catch (e:Dynamic)
        {
            trace("StorageSystem LIST ERROR: " + e);
        }

        return [];
    }
}