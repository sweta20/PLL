package com.company;

import java.awt.*;
import java.awt.event.*;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;


public class Calculator {

    private JTextField display = new JTextField("0");
    private double result = 0;
    private String operator = "=";
    private boolean calculating = true;
    JButton[] button = new JButton[16];
    private int labelText1 = 0;  // number selected
    private int labelText2 = 0;  // operator selected

    volatile boolean keepRunning1 = true; //variable to check if thread1 is active
    volatile boolean keepRunning2 = true; //variable to check if thread2 is active


    private void calculate(double n) {
        if (operator.equals("+"))
            result += n;
        else if (operator.equals("-"))
            result -= n;
        else if (operator.equals("*"))
            result *= n;
        else if (operator.equals("/"))
            result /= n;
        else if (operator.equals("="))
            result = n;
        display.setText("" + result);
    }

    public synchronized void selectNumber() {
        /*
        * Function to check which number is selected*/

        String cmd = button[labelText1].getText();
        if ('0' <= cmd.charAt(0) && cmd.charAt(0) <= '9') {
            if (calculating)
                display.setText(cmd);
            else
                display.setText(display.getText() + cmd);
            calculating = false;
        }
    }

    public synchronized void selectOperator() {
        /*
        * Function to check which opeartor is selected*/

        String cmd = button[labelText2].getText();

        double x = Double.parseDouble(display.getText());
        calculate(x);
        operator = cmd;
        calculating = true;

        }


    class highlightNumber implements Runnable {
        @Override
        public synchronized void run() {
            /*
            * Periodically highlight numbers*/
            while (true) {
                    int i = 0;
                    button[i].setBackground(Color.orange);
                    while (keepRunning1) {
                        try {
                            Thread.sleep(1500);
                        } catch (InterruptedException e) {

                            e.printStackTrace();
                        }
                        button[i].setBackground(null);
                        labelText1 = i;
                        button[(i + 1) % 10].setBackground(Color.orange);
                        i = (i + 1) % 10;
                    }

                button[labelText1+1].setBackground(null);
                selectNumber();
                keepRunning1 = true;
            }
        }
    }


    class highlightOperator implements Runnable {
        @Override
        public synchronized void run() {
            /*
            * Periodically highlight operators*/
            while (true) {
                    int l = 10;
                    button[l].setBackground(Color.green);
                    while (keepRunning2) {
                        try {
                            Thread.sleep(1500);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        button[l].setBackground(null);
                        labelText2 = l;
                        if (l == 14) {
                            l = 9;
                        }

                        button[(l + 1) % 15].setBackground(Color.green);
                        l = (l + 1) % 15;
                    }
                if(labelText2==14)
                    button[10].setBackground(null);
                else
                    button[labelText2+1].setBackground(null);
                selectOperator();
                keepRunning2 = true;
            }
        }
    }

    public Calculator() {

        JFrame frame = new JFrame();
        frame.setTitle("Calculator");
        frame.setSize(200, 200);
        frame.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        frame.setLayout(new BorderLayout());

        display.setEditable(false);
        frame.add(display, "North");

        JPanel panel = new JPanel();
        panel.setLayout(new GridLayout(4, 4));

        String buttonLabels = "9876543210/*-=+";
        for (int i = 0; i < buttonLabels.length(); i++) {
            button[i] = new JButton(buttonLabels.substring(i, i + 1));
            panel.add(button[i]);
        }

        frame.add(panel, "Center");
        frame.setVisible(true);
        frame.requestFocus();
        frame.addKeyListener(new KeyListener() {
            @Override
            public void keyTyped(KeyEvent e) {

            }
            @Override
            public void keyPressed(KeyEvent e) {
                int keyCode = e.getKeyCode();
                if (keyCode == KeyEvent.VK_ENTER){
                    keepRunning1 = false;
                }
                if (keyCode == KeyEvent.VK_SPACE){
                    keepRunning2 = false;
                }

            }
            @Override
            public void keyReleased(KeyEvent e) {

            }
        });

        Runnable Task = new highlightNumber();
        Thread t = new Thread(Task);
        t.setName("T1");
        t.start();

        Runnable Task1 = new highlightOperator();
        Thread t1 = new Thread(Task1);
        t1.setName("T2");
        t1.start();
    }


    public static void main(String[] args) {
        Calculator calc = new Calculator();
    }
}