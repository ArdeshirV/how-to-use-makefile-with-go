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
