fuel_plugins_dest="./fuel-plugins"
fuel_ui_dest="./fuel-ui"

all: submodules stop run

submodules:
	@[ -e $(fuel_ui_dest) ] && continue || \
		{ git submodule sync; git submodule update --recursive --remote; }

stop:
	@sudo docker-compose down --remove-orphans

run:
	@sudo docker-compose up --build

clean:
	rm -rf  $(fuel_ui_dest) $(fuel_plugins_dest)
