# Cross site request forgery attacks (XSFR)

## The problem
A basic authentication cookie from `bank.com` means that your browser sends it to bank.com with every request. The idea is that the bank server can recognize you and performs all sensitive financial operations.

While browsing the web in another window, you accidentally come to another site evil.com. That site has JavaScript code that submits a form `<form action="https://bank.com/pay">` to bank.com with fields that initiate a transaction to the hacker's account.

The browser sends cookies every time you visit the site bank.com, EVEN IF THAT FORM WAS SUBMITTED FROM ANOTHER SITE evil.com. So the bank recognizes you and actually performs the payment.

## Possible solutions
- form tokens
Every form of bank.com will be rendered with a protection token that cannot be replicated by other sites. The bank.com server will check for those tokens upon every request and rejects the request that come from unauthorized sources.

- samesite cookie option
A cookie with `samesite=strict` is never sent if the user comes from outside the same site. If authentication cookies have the samesite option set, then XSRF attacks have no chances to succeed, because a submission from evil.com comes without cookies. So bank.com will not recognize the user and will not proceed with the payment.