use t::Helper;

$t->get_ok('/')
  ->status_is(302)
  ->header_like('location',qr|/login$|);

$t->get_ok('/login')
  ->element_exists('input[name="login"][id="login"]')
  ->element_exists('input[type="password"][name="password"][id="password"]')
  ;

for my $p ('/login') {
  $t->post_ok($p, form => { login => 'whatever' })
    ->status_is(401)
    ->element_exists('div.landing-page', 'still on landing page')
    ->text_is('.login button[type="submit"]', 'Login')
    ->text_is('div.alert', 'Invalid username/password.')
    ;
}

$t->get_ok('/register')
  ->element_exists('.register input[name="email"][id="email"]')
  ->element_exists('.register input[type="password"][name="password"][id="register_password"]', 'need custom id to make label target correct element')
  ;

for my $p ('/register') {
  $t->post_ok($p, form => { email => 'whatever' })
    ->status_is(400)
    ->element_exists('div.landing-page', 'still on landing page')
    ->element_exists('.register input[type="submit"][value="Register"]', 'Register button')
    ->element_exists('div.error:nth-of-type(2)')
    ;
}

done_testing;
