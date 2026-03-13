Testing the demo site https://ecommerce-playground.lambdatest.io/index.php?route=account/register with Robot Framework.

- Registration form: empty fields, wrong email formats + valid test.

- Boundaries tests on the registration form.

- Login form: valid test, empty fields, wrong email, wrong password.

- New tests on the login page with the count of a certain element on the page after login in as an assertion.

- Renamed the resource files as .resource for clarity purpose.
  
- Added new options (headless, sandbox and disable dev shm usage) for Chrome browser to be compatible with Jenkins.
  
- Added Purchase resource and test files.
