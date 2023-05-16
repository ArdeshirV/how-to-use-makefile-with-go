# how-to-use-makefile-with-go
Provides a simple makefile to automate build process of simple go projects
## اتوماتیک کردن کارها

من چون از دنیای زیبایِ زبانِ  C آمده‌ام (که پدر آفرینش است) عادت کرده‌ام که برای اتوماتیک کردن کارها ازAutotools و بویژه از makefileها کمک بگیرم. فرض کنید یک پروژه‌ی ساده داریم که می‌خواهیم برخی فرایندهایِ ساده‌ی کامپایل و تست آن را اتوماتیک کنیم. من برای پروژه‌های ساده‌ی زبان گو همانند تمرینات بوت کمپ از یک makefile با محتویِ زیر استفاده می‌کنم. فرض کنید که نام پروژه‌ی فرضی ما how-to-use-makefile-with-go باشد؛ آنگاه makefile من می‌تواند به شکل زیر باشد:


    project_name=how-to-use-makefile-with-go

    github=github.com/ArdeshirV
    target_ext=  # ".exe" for windows
    temporary_folder=./tmp
    tool=go
    source_ext=go
    mod_file=go.mod
    formatter=gofmt
    compiler=$(tool) build
    executer=$(tool) run
    main_file_name=main
    main_file=$(main_file_name).$(source_ext)
    target=$(project_name)  # .$(target_ext) just for windows
    target2=$(main_file_name)  # .$(target_ext) just for windows
    temp=$(temporary_folder)/$(main_file)

    $(target): $(main_file) update
      $(compiler) $(main_file)

    build: $(target) update

    run: $(main_file) update
      $(executer) $(main_file)

    init: $(main_file)
      $(tool) mod init $(github)/$(project_name)
      $(tool) mod tidy

    update: $(main_file)
      $(tool) get -u

    test: $(main_file) clean
      $(tool) test ./... -count=1 -v

    fmt: $(main_file)
      [ -e $(temporary_folder) ] && rm -fR $(temporary_folder) || echo -n
      mkdir $(temporary_folder)
      $(formatter) $(main_file) > $(temp)
      [ -e $(temp) ] && cat $(temp) > $(main_file) && rm -f $(temp) || echo -n
      [ -e $(temporary_folder) ] && rm -fR $(temporary_folder) || echo -n

    format: fmt

    clean:
      [ -e $(target2) ] && rm -f $(target2) || echo -n
      [ -e $(target) ] && rm -f $(target) || echo -n


فرض کنید در کنار فایل makefile بالا یک برنامه‌ی ساده‌ی گو هم در فایلِ main.go به شکل زیر داریم(که اینجا عمدا به شکل زشتی نوشته شده‌ است):

    package main
    import ("fmt")
    func main() {
    fmt.Printf("The Go Programming Language\n")
    }


حالا با داشتن makefile بالا و به شرط نصب بودن ابزار make و در مسیر فایل‌های اجرایی تعریف شده بودن برنامه‌های autotools که اغلب همراه با کامپایلر زبانِ مقدس C نصب می‌شوند می‌توانیم دستورات جالب زیر را وارد کنیم:

    make init
که دستورات زیرا را اجرا خواهد کرد:

    go mod init github.com/ArdeshirV/how-to-use-makefile-with-go
    go mod tidy


و یا با دستور زیر:

    make
    
    
فایل خروجی و اجرایی برنامه ساخته خواهد شد و قابل اجرا خواهد بود.
و با دستور زیر:

    make clean
    
    
تمامی فایل‌های اضافی برنامه و فایل‌های اجرایی ساخته شده را می‌توانیم حذف کنیم.
و نیز با دستور بسیار جالب:

    make fmt
    
    
سورس کد برنامه با فرمت استاندارد زبان گو بازنویسی خواهد شد و در نتیجه فایل زشتِ main.go که در بالا دیدیم با دستور بالا به شکلِ زیبایِ زیر بازسازی خواهد شد:

    package main

    import (
      "fmt"
    )

    func main() {
      fmt.Printf("The Go Programming Language\n")
    }

برای تست برنامه در صورت وجود تست فایل‌ها نیز می‌توان دستور زیر را وارد کرد:

    make test
    
    
که خودش علاوه بر پاک کردن فایل‌های غیر ضروری پروژه دستورات زیر را اجرا خواهد کرد:

    go test ./... -count=1 -v
 
 
برای دیدن یک پروژه‌ی ساده‌ی نمونه که می‌تواند الگوی کار شما باشد می‌توانید به این [رپوسیتوری](https://github.com/ArdeshirV/how-to-use-makefile-with-go/) مراجعه فرمایید:

https://github.com/ArdeshirV/how-to-use-makefile-with-go/

و شاید بهترست که همین الآن آن را کلون کنید:

    git clone https://github.com/ArdeshirV/how-to-use-makefile-with-go/


### این پروژه را تقدیم می‌کنم به استاد عزیزم [❤روزبه شریفی نصب❤](https://github.com/rsharifnasab) 

#ArdeshirV
