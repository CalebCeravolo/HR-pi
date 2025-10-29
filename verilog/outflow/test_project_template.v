
// Efinity Top-level template
// Version: 2025.1.110
// Date: 2025-10-28 20:07

// Copyright (C) 2013 - 2025 Efinix Inc. All rights reserved.

// This file may be used as a starting point for Efinity synthesis top-level target.
// The port list here matches what is expected by Efinity constraint files generated
// by the Efinity Interface Designer.

// To use this:
//     #1)  Save this file with a different name to a different directory, where source files are kept.
//              Example: you may wish to save as test_project.v
//     #2)  Add the newly saved file into Efinity project as design file
//     #3)  Edit the top level entity in Efinity project to:  test_project
//     #4)  Insert design content.


module test_project
(
  (* syn_peri_port = 0 *) input Button1,
  (* syn_peri_port = 0 *) input Button2,
  (* syn_peri_port = 0 *) input CS,
  (* syn_peri_port = 0 *) input SPI_CLK,
  (* syn_peri_port = 0 *) input SPI_incoming,
  (* syn_peri_port = 0 *) input pllREF_CLK,
  (* syn_peri_port = 0 *) input CLK_50,
  (* syn_peri_port = 0 *) input osc_inst1,
  (* syn_peri_port = 0 *) output SPI_outgoing,
  (* syn_peri_port = 0 *) output [3:0] led
);


endmodule

