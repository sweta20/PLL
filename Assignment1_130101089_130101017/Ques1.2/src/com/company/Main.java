package com.company;

import java.util.*;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {

    //Queue to store raw data generated from each sensor
    public static Queue<Integer>[] queues = new Queue[10];

    public static class generateNum implements Runnable {
        /* This function generates 8-bit binary strings for each sensor and
        also converts them to integr for further operations*/
        private final int threadnum;

        generateNum(int threadnum){
            this.threadnum = threadnum;
        }

        @Override
        public  synchronized void run() {
            while(true) {
                //Generates binary strings of length 8
                String bits = "";
                Random r = new Random();
                for (int i = 0; i < 8; i++) {
                    int x = 0;
                    if (r.nextBoolean()) x = 1;
                    bits += x;
                }
                //Thread is made to sleep for concurrency
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                //The raw data is converted to a digit and is added to the queue of respective threads
                int number = Integer.parseInt(bits, 2);
                if(queues[threadnum]==null){
                    queues[threadnum] = new  LinkedList<Integer>();
                }
                queues[threadnum].add(number);
            }
        }
    }

    public static class operate implements Runnable{
        /*
        * This function takes the raw data from all sensors and perform operation add, average and multiply*/
        @Override
        public void run() {
            while(true) {
                //Get the number from the queues of the threads
                int sum = 0;
                float mul = 1;
                int[] myIntArray = new int[10];
                for (int i = 0; i < 10; i++) {
                    while (queues[i] == null || queues[i].isEmpty()) {
                        try {
                            Thread.sleep(1000);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    int ele = com.company.Main.queues[i].remove();
                    sum += ele;
                    mul *= ele;
                    myIntArray[i] = ele;
                }

                //Check for several conditions
                    /*
                    * The result of each fusion operation is compared with a threshold value. If the computed
                      value exceeds the threshold, the program outputs “state detected from (ops)”. Otherwise
                      the program outputs “state not detected from (ops)”. Assume for average the threshold is
                      100, for multiplication the threshold is 100000 and for addition, the threshold is 10000.*/

                //State for add
                float average = sum / 10;
                if (sum >= 10000) {
                    System.out.println("State detected from add");
                } else {
                    System.out.println("State not detected from add");
                }

                //State for multiply
                if (mul >= 100000) {
                    System.out.println("State detected from multiply");
                } else {
                    System.out.println("State not detected from multiply");
                }

                //State for Average
                if (average >= 100) {
                    System.out.println("State detected from average");
                } else {
                    System.out.println("State not detected from average");
                }
            }
        }
    }


    public static void mainFunc() {

        ExecutorService executor = Executors.newFixedThreadPool(10);
        for (int i = 0; i < 10; i++) {
            Runnable task = new generateNum(i);
            executor.submit(task);
        }
        executor.shutdown();

        Runnable task1 = new operate();
        Thread t = new Thread(task1);
        t.start();
    }


    public static void main(String[] args) {
        Main m = new Main();
        m.mainFunc();
    }

}
