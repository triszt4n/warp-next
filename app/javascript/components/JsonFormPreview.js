import React from "react"
import PropTypes from "prop-types"
import Form from "@rjsf/bootstrap-4";

class JsonFormPreview extends React.Component {
    render() {
        return (
            <Form
                schema={JSON.parse(this.props.schema)}
                uiSchema={JSON.parse(this.props.uischema)}
                formData={JSON.parse(this.props.form_data || '{}')}
                children={true}
                tagName="div"
            />
        );
    }
}

JsonFormPreview.propTypes = {
    schema: PropTypes.string,
    uischema: PropTypes.string,
    form_data: PropTypes.string
}
;
export default JsonFormPreview
