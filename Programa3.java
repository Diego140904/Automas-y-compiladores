/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Lenovo
 */
import java.io.*;
import java.util.regex.*;

public class Programa3 {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Por favor, pasa el nombre del archivo como argumento.");
            return;
        }

        String archivo = args[0];

        String contenido = leerArchivo(archivo);
        
        if (contenido == null) {
            return;
        }

        clasificarLexemas(contenido);
    }

    public static String leerArchivo(String archivo) {
        StringBuilder contenido = new StringBuilder();
        
        try (BufferedReader br = new BufferedReader(new FileReader(archivo))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                contenido.append(linea).append(" ");
            }
        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
            return null;
        }
        
        return contenido.toString();
    }

    public static void clasificarLexemas(String contenido) {
        contenido = contenido.trim();

        int totalCaracteresConEspacios = contenido.length();
        int totalCaracteresSinEspacios = contenido.replace(" ", "").length();

        String[] lexemas = contenido.split("\\s+");
        
        int totalLexemas = lexemas.length;
        int totalPalabras = 0;
        int totalNumeros = 0;
        int totalCombinadas = 0;

        for (String lexema : lexemas) {
            if (lexema.matches("\\d+")) {
                totalNumeros++;
            }
            else if (lexema.matches("[a-zA-Z]+")) {
                totalPalabras++;
            }
            else if (lexema.matches(".*[a-zA-Z].*\\d+.*|.*\\d+.*[a-zA-Z].*")) {
                totalCombinadas++;
            }
        }

        System.out.println("Total de caracteres (con espacios): " + totalCaracteresConEspacios);
        System.out.println("Total de caracteres (sin espacios): " + totalCaracteresSinEspacios);
        System.out.println("Total de lexemas: " + totalLexemas);
        System.out.println("Total de palabras: " + totalPalabras);
        System.out.println("Total de números: " + totalNumeros);
        System.out.println("Total de combinadas: " + totalCombinadas);
    }
}