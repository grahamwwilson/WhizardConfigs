########################################################################
#
# Copyright (C) 1999-2017 by 
#     Wolfgang Kilian <kilian@physik.uni-siegen.de>
#     Thorsten Ohl <ohl@physik.uni-wuerzburg.de>
#     Juergen Reuter <juergen.reuter@desy.de>
#     with contributions from
#     Christian Speckner <cnspeckn@googlemail.com>
#
# WHIZARD is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by 
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# WHIZARD is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
########################################################################

model = SM_CKM
mW = 80.369
mH = 125.2

alias parton = u:U:d:D:s:S:c:C:g
alias jet = parton

alias q = u:U:d:D:s:S:c:C
alias leptons = e1:E1:E2:n2
?write_raw=false
sample_format = lhef
#?vis_diags = true

# W+ W+ W-
process WWWP1 = parton, parton => E1, n1, E1, n1, e1, N1
process WWWP2 = parton, parton => E1, n1, E2, n2, e1, N1
process WWWP3 = parton, parton => E2, n2, E2, n2, e1, N1
process WWWP4 = parton, parton => E1, n1, E1, n1, e2, N2
process WWWP5 = parton, parton => E1, n1, E2, n2, e2, N2
process WWWP6 = parton, parton => E2, n2, E2, n2, e2, N2
# W- W- W+
process WWWM1 = parton, parton => e1, N1, e1, N1, E1, n1
process WWWM2 = parton, parton => e1, N1, e2, N2, E1, n1
process WWWM3 = parton, parton => e2, N2, e2, N2, E1, n1
process WWWM4 = parton, parton => e1, N1, e1, N1, E2, n2
process WWWM5 = parton, parton => e1, N1, e2, N2, E2, n2
process WWWM6 = parton, parton => e2, N2, e2, N2, E2, n2

# Need to set s,c quark masses to zero for this to work.
ms=0
mc=0

compile

sqrts = 13600.0
beams = p, p => pdf_builtin
$pdf_builtin_set = "cteq6l" 

cuts = all M > 4.0 GeV [combine [e1, E1]] 
       and all M > 4.0 GeV [combine [e2, E2]] 

$integration_method = "vamp2"

integrate (WWWP1, WWWP2, WWWP3, WWWP4, WWWP5, WWWP6, WWWM1, WWWM2, WWWM3, WWWM4, WWWM5, WWWM6) { iterations = 10:25000, 5:50000 }
n_events = 25000

# Define title etc. as global variables, that will be used by PLOT
$description =
  "$\mathrm{p} \mathrm{p} \to \mu^{+} \nu_{\mu} e^{+} e^{-} $ at $\sqrt{s} = 13.6$~TeV"
$y_label = "$N_{\textrm{events}}$"

# Allocate plots

$title = "Cos Theta ($e^{-}$)"
$x_label = "$\cos{\theta_{e^{-}}}$"
histogram costhe (-1.0, 1.0, 0.1)

$title = "Cos Theta ($e^{+}$)"
$x_label = "$\cos{\theta_{e^{+}}}$"
histogram costhp (-1.0, 1.0, 0.1)

$title = "Cos Theta ($\mu^{+}$)"
$x_label = "$\cos{\theta_{\mu^{+}}}$"
histogram costhm (-1.0, 1.0, 0.1)

$title = "Cos Theta ($\nu_{\mu}$)"
$x_label = "$\cos{\theta_{\nu_{\mu}}}$"
histogram costhn (-1.0, 1.0, 0.1)

$title = "Eta ($e^{-}$)"
$x_label = "$\eta_{e^{-}}$"
histogram etae (-7.5, 7.5, 0.1)

$title = "Eta ($e^{+}$)"
$x_label = "$\eta_{e^{+}}$"
histogram etap (-7.5, 7.5, 0.1)

$title = "Eta ($\mu^{+}$)"
$x_label = "$\eta_{\mu^{+}}$"
histogram etam (-7.5, 7.5, 0.1)

$title = "Eta ($\nu_{\mu}$)"
$x_label = "$\eta_{\nu_{\mu}}$"
histogram etan (-7.5, 7.5, 0.1)

$title = "Dielectron Mass"
$x_label = "$m_{e^{+}e^{-}}$ [GeV]"
histogram mdiel (0.0, 250.0, 2.5)

$title = "Dielectron pT"
$x_label = "$p_{T} (e^{+}e^{-})$ [GeV]"
histogram ptdiel (0.0, 250.0, 2.5)

$title = "Muon-Neutrino Mass"
$x_label = "$m_{\mu^{+} \nu_{\mu}}$ [GeV]"
histogram mmunu (0.0, 250.0, 2.5)

$title = "Trilepton Mass"
$x_label = "$m_{e^{+} e^{-} \mu^{+}}$ [GeV]"
histogram mtri (0.0, 750.0, 2.5)

$title = "Fourlepton Mass"
$x_label = "$m_{e^{+} e^{-} \mu^{+} \nu_{\mu}}$ [GeV]"
histogram mquad (0.0, 1000.0, 5.0)

$title = "Fourlepton pT"
$x_label = "$p_{T} (e^{+} e^{-} \mu^{+} \nu_{\mu})$ [GeV]"
histogram ptquad (0.0, 200.0, 2.5)

$title = "MET"
$x_label = "$\mathrm{MET}$ [GeV]"
histogram hmet (0.0, 200.0, 2.0)

analysis = record costhe (eval cos(Theta)[e1]);
           record costhp (eval cos(Theta)[E1]);
           record costhm (eval cos(Theta)[E2]); 
           record costhn (eval cos(Theta)[n2]);
           record etae (eval Eta [e1]);  
           record etap (eval Eta [E1]);  
           record etam (eval Eta [E2]);  
           record etan (eval Eta [n2]);                                                                
           record mdiel (eval M [e1, E1]);
           record ptdiel (eval Pt [combine [e1,E1]]);
           record mmunu (eval M [E2, n2]);
           record mtri (eval M [combine [e1,E1], E2]);
           record mquad (eval M [combine [e1,E1], combine [E2, n2]]);
           record ptquad (eval Pt [combine [e1,E1], combine [E2, n2]]);
           record hmet (eval Pt [n2])                               

simulate ( WWWP1, WWWP2, WWWP3, WWWP4, WWWP5, WWWP6, WWWM1, WWWM2, WWWM3, WWWM4, WWWM5, WWWM6 ) 

compile_analysis { $out_file = "WWWP1.dat" }
