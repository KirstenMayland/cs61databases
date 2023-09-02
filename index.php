<?php
    // disable errors
    error_reporting(0);

    $day=$_POST['day'];
    $attribute=$_POST['attribute'];

    if (!isset($_POST['day']) or !isset($_POST['attribute'])) {
        $_POST['day'] = -1;
        $_POST['attribute'] = "cat";
    }


    // database details
    $host = "localhost:3306";
    $username = "root";
    $password = "";
    $dbname = "russia_losses";

    // creating a connection
    $con = mysqli_connect($host, $username, $password, $dbname);

    // to ensure that the connection is made
    if (!$con)
    {
        die("Connection failed!" . mysqli_connect_error());
    }
?>

<html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <head>
        <link rel="stylesheet" href="style.css" type="text/css">
    </head>
    <body>
        <div class ="navbar">
                <b><i><h2>Kirsten Mayland</h2></i></b>
                <a href="index.php">Database</a>
        </div>

        <center>
        <b><h3 style="margin-top: 80px;">Query 'russia_losses' database below:</h3></b>
        
        <div class="form" style="text-align: center;">
            <form method="post" action="index.php">

            <!-- written input -->
            <p>
            <label for="day">Day: </label>
            <input type="text" name="day" placeholder="1-522">
            
            <label for="attribute">Loss Type: </label>
            <input type="text" name="attribute" placeholder="tank">
            </p>

            <!-- buttons -->
            <div id="leftright"> 
                <fieldset style="width: 60%;">
                    <legend>Equipment Loss Options</legend>
                    <p>
                    <input type="button" value="aircraft" />
                    <input type="button" value="helicopter" />
                    <input type="button" value="tank" />
                    <input type="button" value="APC" />
                    <input type="button" value="field artillery" />
                    <input type="button" value="MRL" />
                    <input type="button" value="drone" />
                    <input type="button" value="naval ship" />
                    <input type="button" value="anti-aircraft warfare" />
                    <input type="button" value="special equipment" />
                    <input type="button" value="vehicles and fuel tanks" />
                    <input type="button" value="cruise missiles" />
                    </p>
                </fieldset>
                <fieldset style="width: 40%;">
                    <legend>Personnel Loss Options</legend>
                    <p>
                    <input type="button" value="personnel" />
                    <input type="button" value="POW" />
                    </p>
                </fieldset>
            </div>
            
            <p>
            <input type="submit" value="Submit">
            </p>

            </form>

        </div>

        <script>
            const attribute_val = document.querySelector('input[name="attribute"]');
            const button_op = document.querySelectorAll('input[type="button"]');

            for (const button of button_op) {
                button.addEventListener("click", updateButton, false);
            }
            
            function updateButton(button) {
                attribute_val.value = button.currentTarget.value;
            }
            
        </script>

        <?php
        //set up
        if ($_POST['day'] == -1 or $_POST['attribute'] == "cat") {
            die("Please enter values and submit to begin :)");
        }

        // cumulative loss query
        $q1 = "SELECT c.day, c.`$attribute` FROM 
                (SELECT e.day, `$attribute` 
                FROM equip_loss e JOIN personnel_loss p 
                ON e.day = p.day) AS c
            WHERE c.day = $day";
        $r1 = mysqli_query($con, $q1) or die("Error: check that input is valid.");

        // daily loss query
        $q2 = "SELECT n.day, n.per_day_loss FROM 
                (SELECT e.day, `$attribute` - LAG(`$attribute`) OVER (ORDER BY e.day) AS per_day_loss
                FROM equip_loss e JOIN personnel_loss p ON e.day = p.day) n 
                WHERE n.day = $day;";
        $r2 = mysqli_query($con, $q2) or die("Error: check that input is valid.");

        if (mysqli_num_rows($r1) == 1) {
            $row1 = $r1->fetch_assoc();
            $row2 = $r2->fetch_assoc();
            echo nl2br("Loss of Russian " . "$attribute" . "s on day $day is: $row2[per_day_loss]\n");
            echo "Cumulative loss of Russian " . "$attribute" . "s up until day $day is: $row1[$attribute]";
        }
        else {
            echo "No results, check that input is valid";
        }
        ?>
        </center>
    </body>
</html>

<?php
// close connection
mysqli_close($con);
?>
