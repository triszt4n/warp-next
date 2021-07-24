import React from "react"
import PropTypes from "prop-types"
import {FormBuilder} from "@ginkgo-bioworks/react-json-schema-form-builder";

class JsonFormBuilder extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            schema: this.props.schema,
            uischema: this.props.uischema,
        }
    }

    render() {
        return (
            <div>
                <FormBuilder
                    schema={this.state.schema}
                    uischema={this.state.uischema}
                    onChange={(newSchema, newUiSchema) => {
                        this.setState({
                            schema: newSchema,
                            uischema: newUiSchema
                        })
                    }}
                />
                    <input type="hidden" name="event_type[schema]" value={this.state.schema || '{}'}/>
                    <input type="hidden" name="event_type[uischema]" value={this.state.uischema || '{}'}/>
            </div>
        );
    }
}

JsonFormBuilder.propTypes = {
    schema: PropTypes.string,
    uischema: PropTypes.string,
    token: PropTypes.string
};
export default JsonFormBuilder
