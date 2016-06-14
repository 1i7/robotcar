$fn=100;
//print_error=0;
//print_error=0.1;
print_error=0.2;
//print_error=0.3;

// левое колесо
wheel_with_axis(print_error=print_error);
// правое колесо
//rotate([180, 0, 0]) mirror([0, 0, 1]) wheel_with_axis(print_error=print_error);

// зажим для оси, блокирующий колесо
//axis_jam(3.1);
// прокладка между задним колесом и платформой
//wheel_shim();

/** 
 * Колесо с отверстием под ось.
 *
 * @param print_error погрешность при печати 3д-принтером (мм), стоит 
 * учитывать для элементов (отверстий или штырей), стыкующихся с 
 * внешними объектами (отверстие для вала при печати получится меньше
 * и в него без учета погрешности может быть будет сложно втиснуть ось)
 */
module wheel_with_axis(print_error=0) {
  difference() {
    wheel();
    // ось под круглый вал 2мм
    generic_axis(radius=1, print_error=print_error);
    // ось с лыской (D-образная ось), вал 3мм
    //dshaft_axis(print_error=print_error);
      
    // добавить технологический паз - полусферическое
    // углубление вокруг основания оси, чтобы
    // пластик на первом слое при печати не 
    // забивал отверсие под ось
    translate([0,0,-0.1]) sphere(r=2+print_error, h=1+0.1);
  }
}

/** 
 * Колесо.
 */
module wheel() {

  // внешний обод
  difference() {
    // лысая резина
    //cylinder(h=20, r=25, $fn=100);
    // рельефный протектор
    translate([0, 0, 10]) {
      linear_extrude(height=10, twist=10) 
          import(file = "протектор.dxf");
      mirror([0, 0, -1]) 
        linear_extrude(height=10, twist=10) 
          import(file = "протектор.dxf");
    }

    translate([0, 0, -1])
      cylinder(h=22, r=20, $fn=100);
  }

  // внутренний вал
  cylinder(h=10, r=5, $fn=100);

  // спицы
  for(angle = [0, 72, 144, 216, 288]) {
    rotate(a=angle) rundle();
  }
}

/**
 * Спица.
 */
module rundle() {
  // простая спица 
  //translate([0, -1.5, 0]) cube([22, 3, 10]);
  
  // спица покрасивее
  translate([0, -1.5, 0]) 
    // вычтем из параллелепипеда часть цилиндра, 
    // чтобы получилось скругленное ребро
    difference() {
      cube([22, 3, 20]);
      translate([0, -1, 36]) rotate([270,0,0])
        cylinder(h=5, r=27, $fn=100);
    }
}

/**
 * Стопорная втулка для оси с отверстием под стопорный винт.
 * @param screw_diam диаметр стопорного винта.
 */
module axis_jam(screw_diam=3) {
  difference() {
    // главный вал
    cylinder(h=9, r=5, $fn=100);

    // ось
    generic_axis();
    //dshaft_axis();

    // отверстие под винт m3x6
    translate([0, 0, 3]) rotate([60, 0, 0])
      // винт должен прорезать не только
      // внешнюю стенку, но и внутреннюю 
      // поверхность трубы
      translate([0, 0, -1])
      cylinder(h=10, r=screw_diam/2, $fn=6);

    // полость внутри кольца, чтобы винт легче вкручивался
    translate([0, 0, 1]) difference() {
      cylinder(h=7, r=4, $fn=100);
      // для оси с r=1.5 мм
      cylinder(h=7, r=2.5, $fn=100);      
    }
  }
}

/**
 * Небольшая прокладка между задним колесом и платформой,
 * чтобы клесо при вращении не зацеплялось за платформу.
 */
module wheel_shim(height=3) {
  difference() {
    // внутренний вал
    cylinder(h=height, r=5, $fn=100);

    // ось
    generic_axis();
    //dshaft_axis();
  }
}

/**
 * Просто круглая ось, по умолчанию диаметр 3мм.
 *
 * @param print_error погрешность при печати 3д-принтером (мм), стоит 
 * учитывать для элементов (отверстий или штырей), стыкующихся с 
 * внешними объектами (отверстие для вала при печати получится меньше
 * и в него без учета погрешности может быть будет сложно втиснуть ось)
 */
module generic_axis(length=22, radius=1.5, print_error=0) {
  translate([0,0,-1])
    cylinder(h=length, r=radius+print_error);
}

/** 
 * Ось с лыской (D-shaft - D-образный вал).
 * примеры моторов:
 * 180:1 Mini Plastic Gearmotor, 90° 3mm D-Shaft Output
 * https://www.pololu.com/product/1593
 * 120:1 Mini Plastic Gearmotor, 90° 3mm D-Shaft Output
 * https://www.pololu.com/product/1124
 * 120:1 Mini Plastic Gearmotor HP, 90° 3mm D-Shaft Output
 * https://www.pololu.com/product/1511
 *
 * @param radius радиус оси, диаметр оси мотора 3мм; 
 * @param cut_radius расстояние от центра до поверхности лыски (среза)
 * @param print_error погрешность при печати 3д-принтером (мм), стоит 
 * учитывать для элементов (отверстий или штырей), стыкующихся с 
 * внешними объектами (отверстие для вала при печати получится меньше
 * и в него без учета погрешности может быть будет сложно втиснуть ось)
 */
module dshaft_axis(length=22, radius=1.5, cut_radius=0.9, print_error=0) {
  // диаметр 3мм, срез с одного бока 0.3мм
  translate([0,0,-1])
  difference() {
    cylinder(h=length, r=radius+print_error);
    // 1.5 мм "вниз" по y (совместить куб с цилиндром), 
    // 0.9 мм "вправо" по x (срезать справа, cut_radius=0.9мм)
    translate([cut_radius+print_error, -1.5, 0])
      cube([2, 3, length]);
  }
}
