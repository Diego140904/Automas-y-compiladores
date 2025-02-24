/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Lenovo
 */
import java.util.Scanner;
import java.util.regex.*;

public class Programa2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        

        System.out.println("Introduce la cadena de caracteres:");
        String entrada = sc.nextLine();
        
        clasificar(entrada);
    }
    
    public static void clasificar(String cadena) {
        String[] elementos = cadena.split("\\s+");
        
        int enteros = 0;
        int palabras = 0;
        int compuestas = 0;

        for (String elemento : elementos) {
            if (elemento.matches("\\d+")) {
                enteros++;
            }
            else if (elemento.matches("[a-zA-Z]+")) {
                palabras++;
            }
            else if (elemento.matches(".*[a-zA-Z].*\\d+.*|.*\\d+.*[a-zA-Z].*")) {
                compuestas++;
            }
        }

        if (enteros > 0) {
            System.out.println(enteros + " - entero");
        }
        if (palabras > 0) {
            System.out.println(palabras + " - palabra");
        }
        if (compuestas > 0) {
            System.out.println(compuestas + " - compuesta");
        }
    }
}