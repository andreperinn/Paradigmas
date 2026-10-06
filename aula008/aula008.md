
**André Perin Geraldo**
RA: 24017529-2

---

## 1 - Python

```python
def adicionar(item, lista=[]):
    lista.append(item)
    return lista

print(adicionar(1))
print(adicionar(2))
```

**A) Saída:**
```
[1]
[1, 2]
```

**B)** Ambientes de referenciamento local: variável local estática × dinâmica da pilha (§9.4). O valor padrão `lista=[]` é avaliado uma única vez, na definição da função. Por isso a lista se comporta como uma variável local estática e mantém o valor entre as chamadas.

---

## 2 - Java

```java
static void zera(int[] v, int n) {
    v[0] = 0;
    n = 0;
}
int[] v = {5, 5}; int n = 5;
zera(v, n);
System.out.println(v[0] + " " + n);
```

**A) Saída:**
```
0 5
```

**B)** Em Java toda passagem de parâmetro é por valor (§9.5.4). No `int n` vai uma cópia do valor, então `n = 0` muda só a cópia e o chamador continua com 5. No array `v` vai uma cópia da referência, que aponta para o mesmo array do chamador. Por isso `v[0] = 0` altera o objeto compartilhado e a mudança aparece fora da função.

---

## 3 - Python

```python
fs = [lambda: i for i in range(3)]
print([f() for f in fs])
```

**A) Saída:**
```
[2, 2, 2]
```

**B)** Fechamentos (§9.12). Um fechamento captura a variável, e não uma cópia do valor. As três lambdas compartilham o mesmo `i`, e quando elas são executadas o laço já terminou com `i = 2`. Por isso todas devolvem 2.

---

## 4 - C

```c
int contador(void) {
    static int n = 0;
    return ++n;
}
// em main:
contador(); contador();
printf("%d\n", contador());
```

**A) Saída:**
```
3
```

**B)** Ambientes de referenciamento local: variável local estática × dinâmica da pilha (§9.4). Por causa do `static`, `n` é alocada uma única vez, fora da pilha, e mantém o valor entre as chamadas: as três chamadas devolvem 1, 2 e 3. Se `n` fosse uma local comum (dinâmica da pilha), cada chamada recomeçaria em 0 e a saída seria 1.

---

## 5 - Rust

```rust
fn dobra(v: Vec<i32>) -> Vec<i32> {
    v.iter().map(|x| x * 2).collect()
}
let v = vec![1, 2, 3];
let d = dobra(v);
println!("{:?} {:?}", v, d);
```

**Correção:**
```rust
fn dobra(v: &Vec<i32>) -> Vec<i32> {
    v.iter().map(|x| x * 2).collect()
}

fn main() {
    let v = vec![1, 2, 3];
    let d = dobra(&v);
    println!("{:?} {:?}", v, d);
}
```

**A) Saída:**
```
[1, 2, 3] [2, 4, 6]
```

**B)** Métodos de passagem de parâmetros (§9.5.4). Em Rust, passar um `Vec` por valor move a posse (ownership) para a função. Depois de `dobra(v)`, o `v` do chamador deixa de ser válido, e o `println!` tenta usar um valor que já foi movido. Para manter o `v`, é preciso passar por referência (`&v`), que funciona como passagem de entrada sem cópia e sem transferir a posse.

---

## 6 - Python

```python
total = 0

def adiciona(x):
    total = total + x
    return total

print(adiciona(5))
```

**Correção:**
```python
total = 0

def adiciona(x):
    global total
    total = total + x
    return total

print(adiciona(5))
```

**A) Saída:**
```
5
```

**B)** Ambientes de referenciamento local (§9.4). O `global` faz a função usar a variável global em vez de criar uma local, mas isso gera um efeito colateral.
