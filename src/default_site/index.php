<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><?php echo $_SERVER['HTTP_HOST']; ?></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>

</html>
