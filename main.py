from flask import render_template
from flask_login import login_required

from __init__ import app
from crudy.app_crud import app_crud
from crudy.app_crud_api import app_crud_api

app.register_blueprint(app_crud)
app.register_blueprint(app_crud_api)


@app.route('/')
def index():
    return render_template("index.html")

@app.route('/registration')
@login_required
def registration():
    return render_template("registration.html")

@app.route('/planner')
def planner():
    return render_template("layouts/planner.html")

@app.route('/events')
def events():
    return render_template("pages/events.html")

@app.route('/pace_conversion')
def pace_conversion():
    return render_template("pages/pace_conversion.html")

@app.route('/schedule')
def schedule():
    return render_template("pages/schedule.html")

@app.route('/shop_dnhs')
def shop_dnhs():
    return render_template("pages/shop_dnhs.html")

@app.route('/training_log')
def training_log():
    return render_template("pages/training_log.html")

@app.route('/stats')
def stats():
    return render_template("pages/stats.html")

if __name__ == "__main__":
    # runs the application on the repl development server
    app.run(debug=True, port="5004")
