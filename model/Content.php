<?php

namespace en2portr3s\model;

class Content extends Database {

    private $key;
    private $id;
    private $kind;
    private $page_id;
    private $url;
    private $alt;
    private $body;
    private $lang_code;
    private $since;
    private $modified;

    function __construct() {
        $this->db_name = "en2portr3s";
        $this->key = 'id';
    }

    public function select($key = '') {
        $images_array = $this->getImages($key);
        $text_array = $this->getText($key);
        $this->rows = array_merge($text_array, $images_array);
        array_multisort($this->rows);
        $matches = count($this->rows);
        if ($matches === 0) {
            $this->message = 'Contenido no registrado';
        } else if ($matches === 1) {
            $this->synchronize($this->rows[0]);
            $this->message = 'Contenido encontrado';
        }
        return $this->rows;
    }

    public function getImages($key = '') {
        $this->query = "
            SELECT content.id, content.kind, image.url, image.alt, image.since, image.modified
            FROM content JOIN image ON content.id = image.content_id
        ";
        if ($key !== '') {
            $this->query .= " WHERE content.$this->key = '$key' ";
        }
        $this->retrieve();
        $matches = count($this->rows);
        if ($matches === 0) {
            $this->message = 'Imagen no registrada';
        } else if ($matches === 1) {
            $this->synchronize($this->rows[0]);
            $this->message = 'Imagen encontrada';
        }
        $image = $this->rows;
        $this->rows = [];
        return $image;
    }

    public function getText($key = '') {
        $this->query = "
            SELECT content.id, content.kind, text_entry.body, text_entry.lang_code, text_entry.since, text_entry.modified
            FROM content JOIN text_entry ON content.id = text_entry.content_id
        ";
        if ($key !== '') {
            $this->query .= " WHERE content.$this->key = '$key' ";
        }
        $this->retrieve();
        $matches = count($this->rows);
        if ($matches === 0) {
            $this->message = 'Imagen no registrada';
        } else if ($matches === 1) {
            $this->synchronize($this->rows[0]);
            $this->message = 'Imagen encontrada';
        }
        $text = $this->rows;
        $this->rows = [];
        return $text;
    }

    public function searchParam($key) {
        $this->key = $key;
    }

    public function insert($content_data) {
        if (array_key_exists('id', $content_data)) {
            $this->select($content_data['id']);
            if ($content_data['id'] != $this->id) {
                $this->synchronize($content_data);
                $this->query = "
                    INSERT INTO content(kind)
                    VALUES('$this->kind')
                ";
                $this->modify();
                $this->message = 'Registro exitoso';
            } else {
                $this->message = 'Ese contenido ya está registrado';
            }
        } else {
            $this->message = 'No se ha registrado el contenido';
        }
    }

    public function update($content_data) {
        $this->select($content_data['id']);
        $this->synchronize($content_data);
        if ($this->kind === 'text') {
            $this->query = "
                UPDATE text_entry
                SET body = '$this->body', lang_code = '$this->lang_code'
                WHERE content_id = '$this->id'
            ";
        } else if ($this->kind === 'image') {
            $this->query = "
                UPDATE image
                SET url = '$this->url', alt = '$this->alt'
                WHERE content_id = '$this->id'
            ";
        }
        $this->modify();
        $this->message = 'Contenido modificado';
    }

    public function delete($id) {
        $this->query = "
            DELETE FROM content
            WHERE id = '$id'
        ";
        $this->modify();
        $this->message = 'Contenido eliminado';
    }

    private function synchronize($data) {
        foreach ($data as $propiedad => $valor) {
            $this->$propiedad = $valor;
        }
    }

}
