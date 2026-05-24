<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html dir="rtl" lang="he">
<head>
    <title>DevOps Final Project</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            text-align: center; 
            margin-top: 50px; 
            background-color: #f4f4f9;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            display: inline-block;
        }
        .search-box { 
            padding: 10px; 
            font-size: 16px; 
            width: 250px; 
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn { 
            padding: 10px 20px; 
            font-size: 16px; 
            cursor: pointer; 
            background-color: #4285F4;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .btn:hover { background-color: #357ae8; }
    </style>
</head>
<body>

    <div class="container">
        <h2>פרויקט גמר - DevOps</h2>
        
        <form action="https://www.google.com/search" method="GET" target="_self">
            <label>מה תרצו לחפש היום?</label><br><br>
            
            <input type="text" name="q" class="search-box" placeholder="הקלידו טקסט לחיפוש..." required>
            <br><br>
            
            <input type="submit" class="btn" value="חפש בגוגל">
        </form>

        <br><br>
        <p>
            <a href="https://github.com/OfekLamay/DevOpsFinalProject.git" target="_blank">למעבר לרפוזיטורי ב-GitHub</a>
        </p>
    </div>

</body>
</html>
