<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="testDiv">
	<c:forEach items="${list}" var="item" varStatus="status">
    	<div class="wrap">
          <div>${item}</div>
        </div>
    </c:forEach>
</div>
</body>
</html>