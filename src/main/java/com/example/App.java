package com.example;

public class App {

    public static String hello(String name) {
        return "Hello, " + name + "!";
    }

    public static void main(String[] args) {
        System.out.println(hello("Jenkins"));
    }
}