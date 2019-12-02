exports.config = {
	tests: "./*_test.js",
	output: "./output",
	helpers: {
		REST: {
      endpoint: "https://hidden-hamlet-79766.herokuapp.com/",
			onRequest: () => {
			}
		}
	},
	include: {},
	bootstrap: null,
	mocha: {},
	name: "codeceptjs-rest"
};
