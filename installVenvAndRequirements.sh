# create virtual environment
mkdir -p venv
virtualenv --distribute venv/
source venv/bin/activate
# we should do: pip install -r requirements.txt 
# but...we haven't got a requirements.txt yet (they're in the individual projects)
# so just install the common stuff (which, at the moment, is all we need)
pip install Django==1.5
pip install Pillow
pip install PyGreSQL
pip install pyscopg2
pip install Pygments
pip install solrpy
pip install six
pip install django-extensions
pip install django-filter
pip install django-positions
pip install django-tables2
pip install django-tables2-reports
pip install djangorestframework
pip install itsdangerous
pip install numpy
pip install requests
