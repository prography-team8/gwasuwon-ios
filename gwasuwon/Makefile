remove:
	rm -rf **/**/*.xcodeproj
	rm -rf **/**/Derived
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/**/Derived
	rm -rf *.xcworkspace

clean:
	tuist clean
	make remove
	@if [ -e ./Package.resolved ] ; then \
		rm ./Package.resolved; \
	fi
	@if [ -e ./graph.png ] ; then \
		rm graph.png; \
	fi

generate:
	tuist install
	tuist generate

module:
	@if [[ $(name) =~ Feature ]]; then \
		tuist scaffold Feature --name $(name) --feature $(feature); \
	else \
		tuist scaffold Module --name $(name); \
	fi

util:
	tuist scaffold Util --name $(name)
