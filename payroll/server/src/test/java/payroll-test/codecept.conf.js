exports.config = {
	tests: "./*_test.js",
	output: "./output",
	helpers: {
		REST: {
			endpoint: "http://localhost:8080",
			onRequest: () => {
			}
		}
	},
	include: {},
	bootstrap: null,
	mocha: {},
	name: "codeceptjs-rest"
};
