type X = {
  a?: number;
  b?: number;
  c?: number;
  d?: number;
};

const x: X = {
  a: 1,
  b: 2,
  c: 3,
  d: 4,
};

const y: X = {
    a: 2,
    b: 4,
    c: 8,
}

if (x.a && x.b && x.c) {
  console.warn(x.a + x.b + x.c);
}

if ("a" in x) {
  console.warn(x.a! + 1);
}

function isRequiredX(object: X): object is Required<X> {
  return (
    object.a !== undefined &&
    object.b !== undefined &&
    object.c !== undefined &&
    object.d !== undefined
  );
}

if (isRequiredX(x) && isRequiredX(y)) {
  console.warn(x.a + x.b + x.c + y.a + y.b + y.c + y.d);
} else {
    throw new Error()
}
