# LightQue

:warning: Тестовая версия библиотеки для создание очередей. К продакшену не готова. Также необходимо покрытие большим обьемов тестов

## Introduction

Библиотека для хранение очередей и исполнение их по команде (крону, воркеру).
Реализовано через `umbrella --app` для разделения логики самой очереди с хранилищем `:persistence`
В качестве основого хранилища для задач очереди взят `postgres`


## Configuration

Для работы с нужным хранилищем необходимо прописать в конфиг драйвер,
в данном случае это `Pg`

``` elixir
  config :que, persistance: Pg
```

### Notes
  Для работы либы необходимы  `hex "ecto_sql"`, `hex "postgrex"`



## Usage
  для работы с очередью необходимо придерживатся поместить задчу командой
  `Que.add({IO, :puts, ["Hello"]})` где аргументом является кортеж из модуля, фукции и аргументов.

``` elixir
Que.add({Que, :ack, []})
Que.add({Que, :reject, []})
Que.add({Que, :long_run, [100000]})

Que.get()
```
 Библиотека ожидает от задач возвращения следующих параметров
 - `{:ack}` таск завершился успешно и будет удален как из очереди так из хранилища
 - `{:reject, reason}` в этом случае в хранилище запишется причина и задача поместится в конец очереди для повторного вызова

 ## TODO
 Для улучшения работы либы необходимо доработать ее, а именно:
 - реализовать группы приоритетов и приоритетность задач в группах
 - дописать вспомогательный воркер на проверку всех задач которые фэйлятся и не исполняются c разбором логов и причин
 - Реализовать max_retry логику

