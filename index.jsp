<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // הגדרת רשימת ההוצאות בזיכרון השרת (Session)
    List<Map<String, String>> expenses = (List<Map<String, String>>) session.getAttribute("expenses");
    if (expenses == null) {
        expenses = new ArrayList<Map<String, String>>();
        session.setAttribute("expenses", expenses);
    }

    // קליטת נתונים מהטופס אם נשלחו (בקשת POST)
    String newName = request.getParameter("expenseName");
    String newAmount = request.getParameter("amount");

    if (newName != null && newAmount != null && !newName.trim().isEmpty()) {
        Map<String, String> newExpense = new HashMap<String, String>();
        newExpense.put("name", newName);
        newExpense.put("amount", newAmount);
        expenses.add(newExpense);
    }
%>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>DevOps Cost Manager</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 50px; direction: rtl; }
        .container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 450px; margin: auto; }
        h2 { color: #333; text-align: center; }
        label { font-weight: bold; color: #555; display: block; margin-top: 15px; }
        input[type="text"] { width: 100%; padding: 10px; margin: 5px 0 20px 0; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        button { background-color: #4CAF50; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-size: 16px; }
        button:hover { background-color: #45a049; }
        table { width: 100%; border-collapse: collapse; margin-top: 25px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: right; }
        th { background-color: #f2f2f2; color: #333; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .total-row { font-weight: bold; background-color: #e7f3fe !important; }
        .footer-link { display: block; margin-top: 25px; text-align: center; color: #0066cc; text-decoration: none; font-weight: bold; }
        .footer-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h2>Mini Cost Manager 💸</h2>
    
    <form method="POST" action="">
        <label for="expenseName">תיאור ההוצאה:</label>
        <input type="text" id="expenseName" name="expenseName" placeholder="לדוגמה: שרת ב-DigitalOcean" required>
        
        <label for="amount">סכום ($):</label>
        <input type="text" id="amount" name="amount" placeholder="לדוגמה: 15.50" required>
        
        <button type="submit">הוסף הוצאה</button>
    </form>

    <table id="expensesTable">
        <thead>
            <tr>
                <th>תיאור</th>
                <th>סכום ($)</th>
            </tr>
        </thead>
        <tbody>
            <% 
                double totalSum = 0;
                // הדפסת השורות מהשרת
                for (Map<String, String> exp : expenses) { 
                    double currentAmount = 0;
                    try { currentAmount = Double.parseDouble(exp.get("amount")); } catch(Exception e){}
                    totalSum += currentAmount;
            %>
                <tr>
                    <td><%= exp.get("name") %></td>
                    <td><%= exp.get("amount") %></td>
                </tr>
            <% } %>
        </tbody>
        <tfoot>
            <tr class="total-row">
                <td>סך הכל:</td>
                <td><%= String.format("%.2f", totalSum) %></td>
            </tr>
        </tfoot>
    </table>

    <a href="https://github.com" class="footer-link" target="_blank">צפייה בקוד ב-GitHub</a>
</div>

</body>
</html>
