# Source-only simulation project. Run from Vivado Tcl or batch mode.
set repo [file normalize [file join [file dirname [info script]] ..]]
set build [file join $repo build vivado]
create_project portfolio_sim $build -part xc7a35tcpg236-1 -force
set rtl_files [concat [glob -nocomplain [file join $repo rtl *.v]] [glob -nocomplain [file join $repo rtl *.sv]]]
add_files -norecurse $rtl_files
set_property include_dirs [list [file join $repo rtl]] [get_filesets sources_1]
set_property top top_rv32i_soc [get_filesets sources_1]
set tb_files [concat [glob -nocomplain [file join $repo tb *.v]] [glob -nocomplain [file join $repo tb *.sv]]]
add_files -fileset sim_1 -norecurse $tb_files
set_property top tb_rv32i [get_filesets sim_1]
set mem_files [glob -nocomplain [file join $repo rtl *.mem]]
if {[llength $mem_files]} {
    add_files -norecurse $mem_files
    foreach m $mem_files { set_property file_type {Memory Initialization Files} [get_files $m] }
}
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Project prepared: $build. Launch behavioral simulation from Vivado."
