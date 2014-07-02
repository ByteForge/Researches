<!DOCTYPE html>
<html>	
	<head>
		<meta charset="UTF-8">
		<title>Text Generator - Tester</title>
		<style>
			h2 {
				text-align: center;
			}
			#arg-input {
				font-size: 1.25em;
				width: 85%;
			}
			#btn {
				font-size: 1em;
				font-weight: bold;
				width: 100px;
				height: 32px;
			}
			#resp-label {
				display: block;				
				margin: 10px 0;
				
				font-size: 2em;
				font-weight: bold;
				text-align: center;
			}
				.label-success {
					color: green;
				}
				.label-error {
					color: red;
				}
			#resp-text {
				display: block;
				margin-top: 20px;
				font-size: 1.25em;
				width: 99%;
				height: 500px;
			}			
		</style>
	</head>
	<body>
		<h2>Text Generator - Tester</h2>
		
		<input id="arg-input" type="text"/>
		<input id="btn" type="button" value="Send"/>
		<label id="resp-label"/>-----</label>
		<textarea id="resp-text"></textarea>
		
		<script src="http://code.jquery.com/jquery-2.1.0.js"></script>
		<script>
			$(function(){		
				
				$("#btn").bind("click",function(e){
					args = $("#arg-input").val();
					label = $("#resp-label");
					resp = $("#resp-text");					
					
					$.ajax({
						type: "POST",
						url: "text.php?"+args,						
						success: function(data){
							label.html("success");
							label.addClass("label-success");
							label.removeClass("label-error");							
							resp.html(data);
						},
						error: function(data){
							label.html("error");
							label.addClass("label-error");
							label.removeClass("label-success");
							resp.html(data);
						}
					});
					
					e.stopPropagation();
				});
			});
		</script>
	</body>
</html>