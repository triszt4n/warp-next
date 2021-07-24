import React from "react"
import PropTypes from "prop-types"
import Form from "@rjsf/bootstrap-4";

class EventRegistrationForm extends React.Component {
    constructor(props) {
        super(props);
        this.onSubmit = this.onSubmit.bind(this);
        this.state = {
            errorMessage: ''
        }
    }
    onSubmit({formData}, e) {
        fetch(this.props.url, {
            method: this.props.method,
            headers: {
                "X-CSRF-Token": this.props.token,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                participation:{
                    form_data: formData,
                    ... ((this.props.method === "POST")? {event_id: this.props.eventId} : {})
                }
            })
        }).then( async response =>{
           if(response.ok){
                const data = await response.json();
                window.location.replace(data.redirect || "/")
           }else{
                this.setState({
                    errorMessage: 'Szerveroldali hiba történt a regisztráció során!'
                })
           }
        })
    }

    render() {
        return (
            <div>
                {this.state.errorMessage && <div className="alert alert-danger" role="alert">
                    {this.state.errorMessage}
                </div>}
                <Form
                    schema={JSON.parse(this.props.schema)}
                    uiSchema={JSON.parse(this.props.uischema)}
                    onSubmit={this.onSubmit}
                    formData={JSON.parse(this.props.form_data || '{}')}
                />
            </div>
        );
    }
}

EventRegistrationForm.propTypes = {
    schema: PropTypes.string,
    uischema: PropTypes.string,
    token: PropTypes.string,
    eventId: PropTypes.number,
    form_data: PropTypes.string,
    method: PropTypes.string,
    url: PropTypes.string
};
export default EventRegistrationForm
