console.log('_base.js has loaded.');
console.log('pathname: ', window.location.pathname);


var re = /companies\/\d/i;
var match = window.location.pathname.match(re);

if (match) {
  let company_name = document.getElementById('company_name').innerHTML;
  // company_name.addEventListener("click", function (e) {
  //   console.log(e.target);
  // });
  console.log(`The company we are looking at is ${company_name}`)
}



