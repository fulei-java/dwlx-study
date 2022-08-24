package com.dwlx.study.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/dwlx/v1/study/hl")
public class HelloWordController {

    @GetMapping("/{context}")
    public String hlwd(@PathVariable("context") String context) {

        return context;
    }
}
