<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><?php echo $_SERVER['HTTP_HOST']; ?></title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" integrity="sha512-jnSuA4Ss2PkkikSOLtYs8BlYIeeIK1h99ty4YfvRPAlzr377vr3CXDb7sb7eEEBYjDtcYj+AjBH3FLv5uSJuXg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body class="bg-dark text-light">
	<div class="container">
		<div class="row p-5">
			<div class="col-lg-6 mx-auto">
				<div class="card bg-dark text-white-50 border-0 shadow-lg rounded-4 mt-5">
					<div class="card-body p-5">
						<h2 class="fw-bold"><?php echo $_SERVER['HTTP_HOST']; ?></h2>
						<h4><?php echo $_SERVER['SERVER_ADDR']; ?> | <?php echo $_SERVER['REMOTE_ADDR']; ?></h4>
						<p><?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
