#!/bin/sh
mkdir export
# print_error=0
openscad -D "left=true; axis_type=1; print_error=0" -o export/wheel-d2mm-left.stl колесо-4export.scad
openscad -D "left=false; axis_type=1; print_error=0" -o export/wheel-d2mm-right.stl колесо-4export.scad
openscad -D "left=true; axis_type=2; print_error=0" -o export/wheel-d3mm-ds-left.stl колесо-4export.scad
openscad -D "left=false; axis_type=2; print_error=0" -o export/wheel-d3mm-ds-right.stl колесо-4export.scad

# print_error=0.1
openscad -D "left=true; axis_type=1; print_error=0.1" -o export/wheel-d2mm-left-pe0.1.stl колесо-4export.scad
openscad -D "left=false; axis_type=1; print_error=0.1" -o export/wheel-d2mm-right-pe0.1.stl колесо-4export.scad
openscad -D "left=true; axis_type=2; print_error=0.1" -o export/wheel-d3mm-ds-left-pe0.1.stl колесо-4export.scad
openscad -D "left=false; axis_type=2; print_error=0.1" -o export/wheel-d3mm-ds-right-pe0.1.stl колесо-4export.scad

# print_error=0.2
openscad -D "left=true; axis_type=1; print_error=0.2" -o export/wheel-d2mm-left-pe0.2.stl колесо-4export.scad
openscad -D "left=false; axis_type=1; print_error=0.2" -o export/wheel-d2mm-right-pe0.2.stl колесо-4export.scad
openscad -D "left=true; axis_type=2; print_error=0.2" -o export/wheel-d3mm-ds-left-pe0.2.stl колесо-4export.scad
openscad -D "left=false; axis_type=2; print_error=0.2" -o export/wheel-d3mm-ds-right-pe0.2.stl колесо-4export.scad

# print_error=0.2
openscad -D "left=true; axis_type=1; print_error=0.3" -o export/wheel-d2mm-left-pe0.3.stl колесо-4export.scad
openscad -D "left=false; axis_type=1; print_error=0.3" -o export/wheel-d2mm-right-pe0.3.stl колесо-4export.scad
openscad -D "left=true; axis_type=2; print_error=0.3" -o export/wheel-d3mm-ds-left-pe0.3.stl колесо-4export.scad
openscad -D "left=false; axis_type=2; print_error=0.3" -o export/wheel-d3mm-ds-right-pe0.3.stl колесо-4export.scad

