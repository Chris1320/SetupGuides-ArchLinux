#!/usr/bin/env bash

cache_dir="$HOME/.cache/eww/weather"
cache_weather_stat="${cache_dir}/weather-stat"
cache_weather_degree="${cache_dir}/weather-degree"
cache_weather_hex="${cache_dir}/weather-hex"
cache_weather_icon="${cache_dir}/weather-icon"
cache_weather_city="${cache_dir}/weather-city"
cache_weather_country="${cache_dir}/weather-country"

if [[ -z "$OPENWEATHERMAP_API_KEY" ]]; then
    echo "Please set OPENWEATHERMAP_API_KEY environment variable"
    echo "You can get your API key here: https://home.openweathermap.org/api_keys"
    exit 1
fi
if [[ -z "$OPENWEATHERMAP_CITY_ID" ]]; then
    echo "Please set OPENWEATHERMAP_CITY_ID environment variable"
    echo "You can find your city id here: https://openweathermap.org/find"
    exit 1
fi

UNIT="metric"  # Available options : 'metric' or 'imperial'

if [[ ! -d "$cache_dir" ]]; then mkdir -p "${cache_dir}"; fi

get_weather_data() {
    API_ENDPOINT="https://api.openweathermap.org/data/2.5/weather"
    weather_data_url="$API_ENDPOINT?APPID=$OPENWEATHERMAP_API_KEY&id=$OPENWEATHERMAP_CITY_ID&units=$UNIT"
    weather=$(curl -sf "$weather_data_url")
	echo "${weather}"

	if [ -n "$weather" ]; then
        weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
        weather_city=$(echo "$weather" | jq -r ".name" | head -1)
        weather_country=$(echo "$weather" | jq -r ".sys.country" | head -1)
        weather_icon_code=$(echo "$weather" | jq -r ".weather[].icon" | head -1)
        weather_description=$(echo "$weather" | jq -r ".weather[].description" | head -1 | sed -e "s/\b\(.\)/\u\1/g")

		#Big long if statement of doom
		if [ "$weather_icon_code" == "50d"  ]; then
			weather_icon=""
			weather_hex="#7AA2F7"

		elif [ "$weather_icon_code" == "50n"  ]; then
			weather_icon=""
			weather_hex="#7AA2F7"

        elif [ "$weather_icon_code" == "01d"  ]; then
			weather_icon=""
			weather_hex="#E0AF68"
		
        elif [ "$weather_icon_code" == "01n"  ]; then
			weather_icon=""
			weather_hex="#BB9AF7"
		
        elif [ "$weather_icon_code" == "02d"  ]; then
			weather_icon=""
			weather_hex="#A9B1D6"
		
        elif [ "$weather_icon_code" == "02n"  ]; then
			weather_icon=""
			weather_hex="#A9B1D6"
		
        elif [ "$weather_icon_code" == "03d"  ]; then
			weather_icon=""
			weather_hex="#A9B1D6"
		
        elif [ "$weather_icon_code" == "03n"  ]; then
			weather_icon=""
			weather_hex="#A9B1D6"
		
        elif [ "$weather_icon_code" == "04d"  ]; then
			weather_icon=""
			weather_hex="#A9B1D6"
		
        elif [ "$weather_icon_code" == "04n"  ]; then
			weather_icon=""
			weather_hex="#A9B1D6"
		
        elif [ "$weather_icon_code" == "09d"  ]; then
			weather_icon=""
			weather_hex="#7AA2F7"
		
        elif [ "$weather_icon_code" == "09n"  ]; then
			weather_icon=""
			weather_hex="#7AA2F7"
		
        elif [ "$weather_icon_code" == "10d"  ]; then
			weather_icon=""
			weather_hex="#7AA2F7"
		
        elif [ "$weather_icon_code" == "10n"  ]; then
			weather_icon=""
			weather_hex="#7AA2F7"
		
        elif [ "$weather_icon_code" == "11d"  ]; then
			weather_icon=""
            weather_hex="#E0AF68"
		
        elif [ "$weather_icon_code" == "11n"  ]; then
			weather_icon=""
			weather_hex="#E0AF68"
		
        elif [ "$weather_icon_code" == "13d"  ]; then
            weather_icon=""
			weather_hex="#C0CAF5"
		
        elif [ "$weather_icon_code" == "13n"  ]; then
			weather_icon=""
			weather_hex="#C0CAF5"
		
        elif [ "$weather_icon_code" == "40d"  ]; then
			weather_icon=""
			weather_hex="#7DCFFF"
		
        elif [ "$weather_icon_code" == "40n"  ]; then
			weather_icon=""
			weather_hex="#7DCFFF"
		
        else 
			weather_icon=""
			weather_hex="#A9B1D6"
		fi

		echo "$weather_icon" >  "${cache_weather_icon}"
		echo "$weather_city" >  "${cache_weather_city}"
		echo "$weather_country" >  "${cache_weather_country}"
		echo "$weather_description" > "${cache_weather_stat}"
		echo "$weather_temp""°C" > "${cache_weather_degree}"
		echo "$weather_hex" > "${cache_weather_hex}"
	else
		echo "Weather Unavailable" > "${cache_weather_stat}"
		echo "" > "${cache_weather_icon}"
		echo "-" > "${cache_weather_degree}"
		echo "#A9B1D6" > "${cache_weather_hex}"
	fi
}

## Execute
if [[ "$1" == "--getdata" ]]; then get_weather_data
elif [[ "$1" == "--icon" ]]; then cat "${cache_weather_icon}"
elif [[ "$1" == "--city" ]]; then cat "${cache_weather_city}"
elif [[ "$1" == "--country" ]]; then cat "${cache_weather_country}"
elif [[ "$1" == "--temp" ]]; then cat "${cache_weather_degree}"
elif [[ "$1" == "--hex" ]]; then cat "${cache_weather_hex}"
elif [[ "$1" == "--stat" ]]; then cat "${cache_weather_stat}"
fi

