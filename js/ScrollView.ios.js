
import React, {useState} from "react";
import {View} from "react-native";
import RNScrollView from "rn-scrollview/js/RNScrollViewNativeComponent";
import PropTypes from 'prop-types';

const ScrollView = (props) => {
    const {children, containerHeight, containerWidth} = props;
    const [contentHeight, setContentHeight] = useState(0);

    return(
        <RNScrollView
            style={{width: containerWidth, height: containerHeight}}
            contentHeight={contentHeight}
            stickyHeight={0}
            showsIndicator={false}
            bounce={false}
        >
            <View onLayout={(e)=>{
                setContentHeight(e.nativeEvent.layout.height);
            }}>
                {children}
            </View>
        </RNScrollView>
    )
}

ScrollView.defaultProps = {
    containerHeight: 0,
    containerWidth: 0,
}

ScrollView.propTypes = {
    containerHeight: PropTypes.number.isRequired,
    containerWidth: PropTypes.number.isRequired,
}

export default ScrollView;
