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
    private int labelText = 0;  //which button is highlighted currently
    volatile boolean keepRunning = true;


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

    public void func() {
        String cmd = button[labelText].getText();
        if ('0' <= cmd.charAt(0) && cmd.charAt(0) <= '9') {
            if (calculating)
                display.setText(cmd);
            else
                display.setText(display.getText() + cmd);
            calculating = false;
        } else {
            if (calculating) {
                if (cmd.equals("-")) {
                    display.setText(cmd);
                    calculating = false;
                } else
                    operator = cmd;
            } else {
                double x = Double.parseDouble(display.getText());
                calculate(x);
                operator = cmd;
                calculating = true;
            }
        }
    }

    class highlight implements Runnable {
        @Override
        public synchronized void run() {

            int j = 0;
            while (true) {
                /*Highlight buttons periodically. At even intervals numbers are highlighted and at odd operators.*/
                if (j % 2 == 0) {
                    int i = 0;
                    button[i].setBackground(Color.red);
                    while (keepRunning) {
                        try {
                            Thread.sleep(1500);
                        } catch (InterruptedException e) {

                            e.printStackTrace();
                        }
                        button[i].setBackground(null);
                        labelText = i;
                        button[(i + 1) % 10].setBackground(Color.red);
                        i = (i + 1) % 10;
                    }
                } else {
                    int i = 10;
                    button[i].setBackground(Color.red);
                    while (keepRunning) {
                        try {
                            Thread.sleep(1500);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        button[i].setBackground(null);
                        labelText = i;
                        if (i==14) {
                            i = 9;
                        }

                        button[(i + 1) % 15].setBackground(Color.red);
                        i = (i + 1) % 15;
                    }
                }
                    if(labelText==14)
                        button[10].setBackground(null);
                    else
                        button[labelText+1].setBackground(null);
                    func();
                    keepRunning = true;
                    j += 1;
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
                /*
                * Check if the keycode pressed is enter. If yes pause highlighting text. Get input  and then resume/.*/
                int keyCode = e.getKeyCode();
                if (keyCode == KeyEvent.VK_ENTER){
                    keepRunning = false;
                }

            }
            @Override
            public void keyReleased(KeyEvent e) {

            }
        });

        /*This thread periodically highlights buttons*/
        Runnable Task = new Calculator.highlight();
        Thread t = new Thread(Task);
        t.setName("Highlight");
        t.start();

    }


    public static void main(String[] args) {
        Calculator calc = new Calculator();
    }
}