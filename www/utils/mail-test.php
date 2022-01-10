<?php
if(isset($_POST["mail"], $_POST["subject"], $_POST["email"], $_POST["myemail"])){

    $data       = array();
    $boundary 	= md5( uniqid() . microtime() );

    $from      	= strip_tags($_POST["myemail"]);
    $to      	= strip_tags($_POST["email"]);
    $subject 	= strip_tags($_POST["subject"]) ." - ". date('Y-m-d H:i:s');
    $message	= $_POST["mail"];

    // Plain text version of message
    $body = "--$boundary" .PHP_EOL .
       "Content-Type: text/plain; charset=utf-8".PHP_EOL .
       "Content-Transfer-Encoding: base64" . PHP_EOL . PHP_EOL;
    $body .= chunk_split( base64_encode( strip_tags($message) ) );

    // HTML version of message
    $body .= "--$boundary". PHP_EOL .
       "Content-Type: text/html; charset=utf-8". PHP_EOL .
       "Content-Transfer-Encoding: base64". PHP_EOL . PHP_EOL ;
    $message ='<!DOCTYPE html>
            <html>
                <head>
                    <meta charset="UTF-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1" />
                    <title>MailHog email example</title>
                </head>
                <body>
                    '.$_POST["mail"].'
                </body>
            </html>';
    $body .= chunk_split( base64_encode( $message ) );
    $body .= "--$boundary";


    $headers = 'From: PHP <'.$from.'>'.PHP_EOL;
    $headers.= 'Reply-To: PHP <'.$from.'>'.PHP_EOL;
    $headers.= 'CC: '.$from.''.PHP_EOL;
    $headers.= 'MIME-Version: 1.0'.PHP_EOL;
    $headers.= 'Content-Type: multipart/alternative;boundary="'.$boundary.'"'.PHP_EOL;

    if(mail($to, $subject, $body, $headers)){
        $data["success"] = true;
        $data["text"] 	 = "Mail was sent successfully.";
    }else{
        $data["success"] = false;
        $data["text"] = "Mail was not sent.";
    }
    die(json_encode($data));
}
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>PHP Email Test</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css"
                type="text/css" rel="stylesheet" />
    </head>
    <body>
        <div class="container">
            <h2>Send an email from localhost</h2>
            <form onsubmit="sendmail(event)" id="myForm" action="#" method="post">
                <div class="form-group">
                    <label for="myemail">Email From</label>
                    <input type="email" class="form-control" value="php@localhost"
                        name="myemail" placeholder="Email sender" id="myemail" required />
                </div>
                <div class="form-group">
                    <label for="email">Email to</label>
                    <input type="email" class="form-control" value="admin@example.com"
                        name="email" placeholder="Email recipient" id="email" required />
                </div>
                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" class="form-control" value="php test email"
                        name="subject" placeholder="Subject" id="subject" required />
                </div>
                <div class="form-group" id="help-parent">
                    <label for="mail">Email Body</label>
                    <textarea name="mail" class="form-control" id="mail" rows="5" required>
                        <h2>Sent from localhost!</h2>
                    </textarea>
                    <span id="response" class="help-block"></span>
                </div>
                <button type="submit" class="btn btn-info">Send Mail</button>
            </form>
        </div>
        <script>
            function sendmail(event){
                event.preventDefault();
                var mail = document.getElementById("mail").value;
                var email = document.getElementById("email").value;
                var myemail = document.getElementById("myemail").value;
                var subject = document.getElementById("subject").value;
                const toSend = {
                    method : 'post',
                    headers: {
                      "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
                    },
                    body : "email="+encodeURIComponent(email)+
                            "&subject="+encodeURIComponent(subject)+
                            "&mail="+encodeURIComponent(mail)+
                            "&myemail="+encodeURIComponent(myemail)
                };
                fetch('<?=$_SERVER["REQUEST_URI"]?>', toSend)
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    document.getElementById("response").innerHTML = data.text;
                    if(data.success){
                        document.getElementById("help-parent").classList.add("has-success");
                        document.getElementById("help-parent").classList.remove("has-error");
                    }else{
                        document.getElementById("help-parent").classList.remove("has-success");
                        document.getElementById("help-parent").classList.add("has-error");
                    }
                }).catch(function(err){
                    alert("The request resulted in an error.");
                    console.warn(err);
                });
            }
        </script>
    </body>
</html>