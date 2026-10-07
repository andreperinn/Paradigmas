# Vinculação Estática vs Dinâmica

Para cada trecho: **(a)** qual é a saída e **(b)** se a decisão foi tomada na compilação ou na execução.

---

## 1. Java

```java
class Animal {
  String som() { return "..."; }
}
class Cachorro extends Animal {
  String som() { return "au"; }
}
Animal x = new Cachorro();
System.out.println(x.som());
```

**a)** `au`

**b)** **Execução.** A variável é `Animal`, mas o objeto de verdade é um `Cachorro`, então é a versão dele de `som()` que roda (vinculação dinâmica).

---

## 2. C++

```cpp
struct A {
  void f() { cout << "A"; }
};
struct B : A {
  void f() { cout << "B"; }
};
B b; A *p = &b;
p->f();
```

**a)** `A`

**b)** **Compilação.** Como `f()` não é `virtual`, o compilador olha só para o tipo do ponteiro (`A*`) e fixa a chamada em `A::f()`, mesmo que o objeto seja um `B` (vinculação estática).

---

## 3. Java

```java
class A { String nome = "A";
  String getNome() { return nome; } }
class B extends A { String nome = "B";
  String getNome() { return nome; } }
A x = new B();
System.out.println(x.nome + " " + x.getNome());
```

**a)** `A B`

**b)** **As duas.** `x.nome` é resolvido na compilação pelo tipo da variável (`A`), porque campo não tem polimorfismo. Já `getNome()` é decidido na execução pelo objeto real (`B`), por isso devolve `"B"`.

---

## 4. Python

```python
class Contador:
    total = 0
    def __init__(self):
        Contador.total += 1
        self.id = Contador.total

a = Contador(); b = Contador()
print(a.id, b.id, a.total)
```

**a)** `1 2 2`

**b)** **Execução.** `total` pertence à classe (uma cópia só para todos) e `id` é de cada objeto. Ao acessar `a.total`, o Python não acha no objeto e busca na classe, tudo em tempo de execução.

---

## 5. Java

```java
class A {
  static String quem() { return "A"; }
}
class B extends A {
  static String quem() { return "B"; }
}
A x = new B();
System.out.println(x.quem());
```

**a)** `A`

**b)** **Compilação.** Método `static` não é sobrescrito, só fica escondido. O compilador olha o tipo da variável (`A`) e chama `A.quem()`, sem ligar para o objeto real.

---

## 6. Go

```go
type Animal struct{}
func (Animal) Som() string { return "..." }
func (a Animal) Falar() string {
    return "faz " + a.Som()
}
type Cao struct{ Animal }
func (Cao) Som() string { return "au" }

fmt.Println(Cao{}.Falar(), Cao{}.Som())
```

**a)** `faz ... au`

**b)** **Compilação.** Embutir struct em Go não é herança. Dentro de `Falar()`, `a` é um `Animal`, então chama o `Som()` de `Animal`. Já `Cao{}.Som()` chama direto o de `Cao`. Para ter polimorfismo em Go, só com interface.
