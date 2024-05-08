package com.example.testservice.controller;


import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Collections;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

@ServerEndpoint("/websocket")
public class WebSocketServer {
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    public WebSocketServer() {
        org.glassfish.tyrus.server.Server server = new org.glassfish.tyrus.server.Server("localhost", 8889, "/ws", WebSocketServer.class);
        try {
            server.start();
        } catch (DeploymentException e) {
            throw new RuntimeException(e);
        }
    }

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        System.out.println("Client connected");
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Received from client: " + message);
        // Echo back to client
        //startSendingRandomMessages();
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        System.out.println("Connection closed");
    }

    // Method to send message to all connected sessions
    public void startSendingRandomMessages() {
        Thread thread = new Thread(() -> {
            for (int i = 0; i < 60; i++) { // Send for 20 seconds
                try {
                    String message = generateRandomMessage();
                    sendMessageToAllSessions(message);
                    Thread.sleep(1000); // Sleep for 1 second
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        thread.start();
    }

    private String generateRandomMessage() {
        // Generate a random message here
        return "Random message: " + Math.random();
    }

    public void sendMessageToAllSessions(String message) {
        for (Session session : sessions) {
            try {
                session.getBasicRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    public static void main(String[] args) {
        org.glassfish.tyrus.server.Server server = new org.glassfish.tyrus.server.Server("localhost", 8887, "/ws", WebSocketServer.class);

        try {
            server.start();
            System.out.println("Press any key to stop the server..");
            new Scanner(System.in).nextLine();
        } catch (DeploymentException e) {
            throw new RuntimeException(e);
        } finally {
            server.stop();
        }
    }
}
