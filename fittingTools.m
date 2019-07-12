sigmoidFunc         =   @(x) 1./(1+exp(-x));
sigmoidFuncT        =   @(x, a) 1./(1+exp(-a.*x));


probWeightFunc1     =   @(p, gamma) exp(-(-log(p)).^gamma);
probWeightFunc1D    =   @(x, gamma) exp(-(-log(x)).^(1./gamma));
magUtilityFunc      =   @(m, rho_g, rho_l) ((m>0).*(m.^rho_g) + (m<0).*(-(-m).^rho_l));
magUtilityFunc1     =   @(m, rho_g) (m.^rho_g);
magUtilityFunc1D    =   @(x, rho_g) (x.^(1./rho_g));

probWeightFunc1Cum  =   @(p, gamma) p.^gamma/((p.^gamma+(1-p).^gamma).^(1/gamma));


deltaValues1        =   @(mu1, mu2, pw1, pw2, alpha, beta) (alpha.*(mu1.*pw1 - mu2.*pw2) - beta);
ptFunction1         =   @(p1, p2, m1, m2, gamma, rho_g, alpha, beta) ...
                        sigmoidFunc(deltaValues1(magUtilityFunc1(m1, rho_g), magUtilityFunc1(m2, rho_g), probWeightFunc1(p1, gamma), probWeightFunc1(p2, gamma), alpha, beta));
                    
                   