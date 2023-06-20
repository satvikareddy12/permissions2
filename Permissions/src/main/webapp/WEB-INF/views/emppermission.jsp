<!DOCTYPE html>
<html>
<head>
  <title>Permission Application</title>
  <style>
    .container {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-top: 20px;
    }

    form {
      width: 400px;
      margin: 0 auto;
    }

    label {
      display: block;
      margin-top: 10px;
    }

    input[type="text"],
    input[type="date"],
    input[type="time"],
    textarea {
      width: 100%;
      padding: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    textarea {
      resize: vertical;
      height: 100px;
    }

    button {
      width: 100%;
      padding: 10px;
      margin-top: 20px;
      background-color: #358eb8;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function() {
      var today = new Date().toISOString().split("T")[0];
      document.getElementById("current-date").setAttribute("max", today);
      document.getElementById("current-date").setAttribute("min", today);
    });

    function permissionApplied(event) {
      event.preventDefault(); // Prevent default form submission

      $.ajax({
        type: "POST",
        url: "applyPermission",
        data: $("#permissionForm").serialize(), // Serialize form data
        success: function(response) {
          var containerDiv = $(".main");
          containerDiv.html(response);
        },
        error: function() {
          alert("Error occurred. Please try again later.");
        }
      });
    }
  </script>
</head>
<body>
  <div class="container">
    <form id="permissionForm" action="applyPermission" method="post">
  <label for="id">ID:</label>
  <input type="number" id="id" name="id" required>

  <label for="current-date">Current Date:</label>
  <input type="date" id="current-date" name="current_date" required>

  <label for="start-time">Permission Start Time:</label>
  <input type="time" id="start-time" name="start_time" required>

  <label for="end-time">Permission End Time:</label>
  <input type="time" id="end-time" name="end_time" required>

  <label for="reason">Reason:</label>
  <textarea id="reason" name="reason" required></textarea>

  <button type="submit" onclick="permissionApplied(event)">Apply</button>
</form>

  </div>
  <div class="main"></div>
</body>
</html>
