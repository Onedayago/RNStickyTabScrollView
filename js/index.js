
import React, {useRef, useState} from "react";
import {Text, View} from "react-native";
import RNScrollView from "./RNScrollViewNativeComponent";

const ScrollContainer = (props) => {

    const {containerHeight, containerWidth, Header, data} = props;
    const [outerContentH, setOuterContentH] = useState(0);
    const [stickyHeight, setStickyHeight] = useState(0);
    const [arrH, setArrH] = useState([]);

    const renderHeader = () => {
        return(
            <View onLayout={(e)=>{
                setStickyHeight(e.nativeEvent.layout.height);
            }}>
                {Header?.()}
            </View>
        )
    }

    const renderPage = (item, index) => {
        return(
            <RNScrollView style={{width: containerWidth, height: containerHeight}} contentHeight={arrH[index]} key={index}>
                <View onLayout={(e)=>{
                    setArrH((arr)=>{
                        arr[index] = e.nativeEvent.layout.height;
                    })
                }}>
                    <Text>mountChildComponentViewmountChildComponentViewmountChildComponentView</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>dsdfsfds</Text>
                    <Text>mountChildComponentViewmountChildComponentViewmountChildComponentView</Text>
                </View>
            </RNScrollView>
        )
    }

    const renderContent = () => {
        return(
            <View style={{flexDirection: 'row'}}>
                {
                    data.map((item, index)=>{
                        return renderPage(item, index);
                    })
                }
            </View>
        )
    }

    return(
        <RNScrollView style={{width: containerWidth, height: outerContentH-stickyHeight}} contentHeight={outerContentH} stickyHeight={stickyHeight}>
            {renderHeader()}
            {renderContent()}
        </RNScrollView>
    )
}

export default ScrollContainer;
