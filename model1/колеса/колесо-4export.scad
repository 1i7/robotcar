use <колесо.scad>

$fn=100;

// параметры для внешнего скрипта

// погрешность печати
//print_error=0;
//print_error=0.1;
print_error=0.2;
//print_error=0.3;

// левое/правое колесо
//    true - левое колесо
//    false - правое колесо
left=true;

// тип оси
//    1 - обычная круглая ось 2мм
//    2 - ось с лыской 3мм
axis_type = 1;

wheel_with_axis_4export(left=left, axis_type=axis_type, print_error=print_error);


/** 
 * Колесо с отверстием под ось.
 *
 * @param left левое или правое колесо
 *     true - левое колесо
 *     false - правое колесо
 * @param axis_type тип оси: 
 *     1 - обычная круглая ось 2мм
 *     2 - ось с лыской 3мм
 * @param print_error погрешность при печати 3д-принтером (мм), стоит 
 * учитывать для элементов (отверстий или штырей), стыкующихся с 
 * внешними объектами (отверстие для вала при печати получится меньше
 * и в него без учета погрешности может быть будет сложно втиснуть ось)
 */
module wheel_with_axis_4export(left=true, axis_type=1, print_error=0) {
  difference() {
    if(left) {
      wheel();
    } else {
      mirror([1, 0, 0]) wheel();
    }
    
    if(axis_type == 2) {
      // ось с лыской (D-образная ось), вал 3мм
      dshaft_axis(print_error=print_error);
    } else {
      // ось под круглый вал 2мм
      generic_axis(radius=1, print_error=print_error);
    }
      
    // добавить технологический паз - полусферическое
    // углубление вокруг основания оси, чтобы
    // пластик на первом слое при печати не 
    // забивал отверсие под ось
    translate([0,0,-0.1]) sphere(r=2+print_error, h=1+0.1);
  }
}
