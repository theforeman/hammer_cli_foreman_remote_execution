��    @        Y         �  P   �     �  !   �  #        7  !   V  #   x     �  !   �     �  	   �  �        �  :   �  0        9  G   A  	   �     �     �     �     �     �     �     �     �  
   	     	     	     $	     A	     V	     k	     �	     �	     �	     �	     �	     �	     �	     �	  )   �	     
  A   '
     i
     r
     �
     �
     �
  '   �
      �
                    $     7     L     c     z     �     �     �     �  K  �  �     I   �  >     X   A  M   �  B   �  B   +  @   n  1   �  @   �     "  �   4     #  n   4  c   �       �        �     �  B   �  B   8  F   {     �     �     �     �       !   !     C  G   V  (   �  (   �  ,   �  
     Z   (  4   �  6   �  6   �  
   &     1     8  %   K     q  ~   �            >   ,  [   k  2   �  %   �  Q         r          �  D   �  0   �  ,     ,   >  
   k     v     }  C   �  $   �     <       0                     $      (   @   4   %                             ,   5   8       "          =   '   !   6               :   7   -                     )      2             ?      >          *   1             ;         
   .             #      	          /   9                           +      3             &    Comma-separated list of key=file, where file is a path to a text file to be read Could not create the input set Could not create the job template Could not create the template input Could not delete the input set Could not delete the job template Could not delete the template input Could not update the input set Could not update the job template Create a recurring execution Cron line Cron line format 'a b c d e', where:
  a. is minute (range: 0-59)
  b. is hour (range: 0-23)
  c. is day of month (range: 1-31)
  d. is month (range: 1-12)
  e. is day of week (range: 0-6) Description Do not wait for job to complete, shows current output only Dynamic search queries are evaluated at run time Exclude Execution should be cancelled if it cannot be started before --start-at Fact name Failed Foreign input set created Foreign input set deleted Foreign input set updated Hosts ID Include Include all Input type Inputs Job Category Job invocation %{id} created Job template created Job template deleted Job template updated Label Manage foreign input sets Manage job invocations Manage job templates Manage template inputs Mode Name Options Path to a file that contains the template Pending Perform no more executions after this time, used with --cron-line Provider Puppet parameter name Read input values from files Recurring logic ID Rerun the job Schedule the execution for a later time Specify inputs from command line Start Status Success Target template ID Target template name Template input created Template input deleted Total Type Variable name View job template content View the output for a host Project-Id-Version: hammer-cli-foreman-remote-execution 0.2.3
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2019-02-26 10:44-0500
PO-Revision-Date: 2016-02-12 07:57+0000
Last-Translator: Yulia <yulia.poyarkova@redhat.com>, 2016
Language-Team: Russian (http://app.transifex.com/foreman/foreman/language/ru/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: ru
Plural-Forms: nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || (n%10>=5 && n%10<=9) || (n%100>=11 && n%100<=14)? 2 : 3);
 Список пар КЛЮЧ=ФАЙЛ через запятую, где ФАЙЛ — путь к текстовому файлу с входными данными Не удалось создать набор входных данных Не удалось создать шаблон задания Не удалось создать входной параметр для шаблона Ошибка при удалении набора входных данных Ошибка при удалении шаблона задания Не удалось удалить входной параметр Не удалось обновить входные данные Не удалось обновить шаблон Настроить многократное выполнение Строка Cron Строка cron определяется в виде «a b c d e», где:
  a — минуты (0–59)
  b — часы (1–24)
  c — месяц (1–12)
  d — день месяца (1–31)
  e — день недели (0–6) Описание Не дожидаться завершения задания (показывает текущий вывод) Динамические запросы обрабатываются во время запуска Исключить Если действие не будет запущено до указанного времени (заданным с помощью --start-at), его следует отменить Имя факта Ошибка Внешний набор входных данных создан Внешний набор входных данных удален Внешний набор входных данных обновлен Узлы Идентификатор Включить Включить все Тип ввода Входные параметры Категория Настройка вызова задания %{id} завершена Шаблон задания создан Шаблон задания удален Шаблон задания обновлен Метка Управление внешними наборами входных параметров Управление вызовами заданий Управление шаблонами заданий Управление параметрами ввода Режим Имя Параметры Путь к файлу шаблона Ожидание Остановить после указанного числа повторений (используется с --cron-line) Провайдер Параметр Puppet Получать входные данные из файлов Идентификатор правила периодического выполнения Повторно выполнить задание Отложить выполнение Ввести входные параметры в командной строке Начало Статус Успешно Идентификатор подключаемого шаблона Имя подключаемого шаблона Входной параметр создан Входной параметр удален Всего Тип Имя переменной Показать содержимое шаблона задания Показать вывод узла 