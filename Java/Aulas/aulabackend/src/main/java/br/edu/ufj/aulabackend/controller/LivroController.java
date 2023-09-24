package br.edu.ufj.aulabackend.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.edu.ufj.aulabackend.dao.LivroDAO;
import br.edu.ufj.aulabackend.model.Livro;

@RestController
@RequestMapping("/biblioteca/livros")
public class LivroController {

    @Autowired(required = false)
    private LivroDAO dao;

    @GetMapping("/listar/{id}")
    public Optional<Livro> buscarUm(@PathVariable int id) {
        return dao.findById(id);
    }

    @GetMapping("/listar")
    public List<Livro> buscarTodos() {
        return dao.findAll();
    }

    @PostMapping("/gravar")
    public Livro gravar(@RequestBody Livro obj) {
        return dao.save(obj);
    }

    @PostMapping("/gravar/{id}")
    public Livro alterar(@PathVariable int id, @RequestBody Livro obj) {
        obj.setCodigo(id);
        return dao.save(obj);
    }

    @DeleteMapping("/excluir/{id}")
    public void excluir(@PathVariable int id) {
        dao.deleteById(id);
    }
}
