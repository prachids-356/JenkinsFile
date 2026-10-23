<%@ page import="java.util.*" %>

<html>
<head>
    <title>JSP Complete Demo</title>
</head>

<body>

<h1>JSP Scripting Elements Demo</h1>

<!-- ================= SCRIPTLET ================= -->

<%
    // Variables
    String name = "Prachi";
    int age = 22;
    int marks = 85;

    // Arithmetic
    int a = 10;
    int b = 20;
    int sum = a + b;

    // Output using out
    out.println("<h3>Scriptlet Output</h3>");
    out.println("Name: " + name + "<br>");
    out.println("Age: " + age + "<br>");
    out.println("Sum: " + sum + "<br>");

    // if-else
    if (marks >= 40) {
        out.println("Result: PASS<br>");
    } else {
        out.println("Result: FAIL<br>");
    }

    // for loop
    out.println("<h3>For Loop</h3>");

    for (int i = 1; i <= 5; i++) {
        out.println(i + "<br>");
    }

    // while loop
    out.println("<h3>While Loop</h3>");

    int i = 1;

    while (i <= 5) {
        out.println(i + "<br>");
        i++;
    }

    // Array
    int[] arr = {10, 20, 30, 40, 50};

    out.println("<h3>Array</h3>");

    for (int j = 0; j < arr.length; j++) {
        out.println(arr[j] + " ");
    }

    // Switch
    int day = 2;

    out.println("<h3>Switch</h3>");

    switch(day) {
        case 1:
            out.println("Monday");
            break;

        case 2:
            out.println("Tuesday");
            break;

        case 3:
            out.println("Wednesday");
            break;

        default:
            out.println("Invalid day");
    }

    // Session
    session.setAttribute("username", name);

    // Get session value
    String user = (String) session.getAttribute("username");

    out.println("<h3>Session</h3>");
    out.println("Session User: " + user + "<br>");

%>


<!-- ================= EXPRESSION ================= -->

<h3>Expression</h3>

Name: <%= name %> <br>

Age: <%= age %> <br>

Marks: <%= marks %> <br>

Sum: <%= a + b %> <br>

Square of 5: <%= square(5) %> <br>


<!-- ================= REQUEST ================= -->

<h3>Request Information</h3>

Method: <%= request.getMethod() %> <br>

Request URI: <%= request.getRequestURI() %> <br>

Client IP: <%= request.getRemoteAddr() %> <br>


<!-- ================= RESPONSE ================= -->

<%
    response.setContentType("text/html");
%>


<!-- ================= DECLARATION ================= -->

<%!
    // Declaration
    int count = 100;

    // Method declaration
    int square(int n) {
        return n * n;
    }

    int add(int a, int b) {
        return a + b;
    }
%>


<!-- ================= METHOD CALL ================= -->

<h3>Declared Methods</h3>

Addition: <%= add(10, 20) %> <br>

Square: <%= square(10) %> <br>


<!-- ================= SESSION ================= -->

<h3>Session Information</h3>

<%
    String sessionUser =
        (String) session.getAttribute("username");

    out.println("Logged in user: " + sessionUser);
%>


</body>
</html>